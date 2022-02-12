import AWS from 'aws-sdk';

function getEC2() {
    return new AWS.EC2({apiVersion: '2016-11-15', region: 'us-west-2'});
}

function getECS() {
    return new AWS.ECS({apiVersion: '2014-11-13', region: 'us-west-2'});
}

function getELBv2() {
    return  new AWS.ELBv2({apiVersion: '2015-12-01', region: 'us-west-2'});
}

function getAutoScaling() {
    return  new AWS.AutoScaling({apiVersion: '2011-01-01', region: 'us-west-2'});
}

const NAT_INSTANCE_IMAGE_ID = 'ami-0b707a72';

/**
 * Dont hold any state, everything is retrieve dynamically
 */
export default class VpcService {
    
    /**
     * @param {string} tag
     * @return {Promise<string>}
    */
    static async getVpcIdByTag(tag) {
        const res = await getEC2().describeVpcs({
            Filters: [{Name: 'tag:Stack', Values: [tag]}]
        }).promise();

        if (res.Vpcs.length === 0) {
            throw new Error(`No vpc Stack: ${tag} was found`);
        }
        return res.Vpcs[0].VpcId;
    }


    constructor(vpcId) {

        //only these are held in state
        this.ec2 = getEC2();
        this.ecs = getECS();
        this.elbv2 = getELBv2();
        this.autoScaling = getAutoScaling();
        this.vpcId = vpcId;

    }

    //----------- General ----------//
    
    /**
     * Wire subnets to internet gateway
     * @param {Array<string>} subnets
     */
    async createPublicLayer(subnets) {

        //create custom route table for public subnet 
        const routeTableId = await this.createRouteTable();
        for (let subnet of subnets) {
            await this.associateRouteTableToSubnet(routeTableId, subnet);
        }

        const internetGatewayId = await this.createInternetGateway();

        await this.createRoute(routeTableId, internetGatewayId);
    }

    /**
     * Create public subnet with custom route table
     * @param {object} subnetConfig
     * @return {Promise<string>}
     */
    async createPublicSubnet(subnetConfig) {

        const publicSubnetId = await this.createSubnet(subnetConfig);

        //create custom route table for public subnet (main route table will be for private subnets)
        const routeTableId = await this.createRouteTable();
        await this.associateRouteTableToSubnet(routeTableId, publicSubnetId);

        const internetGatewayId = await this.createInternetGateway();

        await this.createRoute(routeTableId, internetGatewayId);

        return publicSubnetId;
    }
    
    /**
     * Create LB and SG for LB, and listener that listens to target group
     * @param {object} loadBalancerSecurityGroupConfig
     * @param {Array<string>} subnets
     * @return {string} load balancer security group (to be used by cluster instances SG)
     */
    //----------- Vpc ----------//
    
    /**
     * Create vpc.  This will also create a default security group, route table, and acl
     * @param {string} cidrBlock
     * @param {string} stackTag
     */
    async createVpcWithTag(cidrBlock, stackTag) {

        const res = await this.ec2.createVpc({
            CidrBlock: cidrBlock
        }).promise();
        this.vpcId = res.Vpc.VpcId;

        await this.ec2.createTags({
            Resources: [this.vpcId],
            Tags: [{Key: 'Stack', Value: stackTag}]
        }).promise();
        this.tag = stackTag;

        console.log(`Created Vpc ${stackTag} : ${this.vpcId}`);
    }
    
    async deleteVpc() {
        try {
            await this.deleteSubnets();
            await this.deleteInternetGateway();
            await this.ec2.deleteVpc({VpcId: this.vpcId}).promise();
        } catch(e) {
            console.log('Error', e);
        }
        console.log(`Deleted Vpc ${this.vpcId}`);
    }

    //----------- Subnet ----------//


    /**
     * @param {object} options
     * @return {string} 
     */
    async createSubnet(options) {

        const params = { VpcId: this.vpcId, CidrBlock: options.cidr }
        if (options.availabilityZone) {
            params.AvailabilityZone = options.availabilityZone;
        }
        //(associates vpc default route table and acl)
        const res = await this.ec2.createSubnet(params).promise();

        const subnetId = res.Subnet.SubnetId;
        console.log(`Created Subnet : ${subnetId}`);
        return subnetId;
    }

    /**
     */
    async deleteSubnets() {
        const subnets = await this.getSubnets();
        for (let subnet of subnets) {
            const subnetId = subnet.SubnetId
            await this.ec2.deleteSubnet({
                SubnetId: subnetId
            }).promise();
            console.log(`Deleted Subnet : ${subnetId}`);
        }
    }

    /**
     * @return {Array<object>}
     */
    async getSubnets() {
        const res = await this.ec2.describeSubnets({
            Filters: [{Name:'vpc-id', Values: [this.vpcId]}]
        }).promise();
        return res.Subnets;
    }

    /**
     * @param {string} cidr
     * @return {string}
     */
    async getSubnetIdByCidr(cidr) {

        const subnets = await this.getSubnets();
        const targetSubnet = subnets.find((subnet) => {
            return subnet.CidrBlock === cidr;
        });
        return targetSubnet && targetSubnet.SubnetId; 
    }

    //----------- Internet Gateway ----------//
    
    /**
     * Create internet gateway and attach to vpc
     */
    async createInternetGateway() {

        const res = await this.ec2.createInternetGateway({}).promise();
        const internetGatewayId = res.InternetGateway.InternetGatewayId;
        console.log(`Created Internet Gateway : ${internetGatewayId}`);

        await this.ec2.attachInternetGateway({
            InternetGatewayId: internetGatewayId,
            VpcId: this.vpcId
        }).promise();

        console.log(`Attached Internet Gateway : ${internetGatewayId} to Vpc ${this.vpcId}`);
        return internetGatewayId;
    }
    
    /**
     */
    async deleteInternetGateway() {

        const res = await this.ec2.describeInternetGateways({
            Filters: [{Name: 'attachment.vpc-id', Values:[this.vpcId]}]
        }).promise();

        const internetGateway = res.InternetGateways[0];
        if (internetGateway) {
            const internetGatewayId = internetGateway.InternetGatewayId;

            //detach internet gateway to vpc
            await this.ec2.detachInternetGateway({
                InternetGatewayId: internetGatewayId,
                VpcId: this.vpcId
            }).promise();

            await this.ec2.deleteInternetGateway({
                InternetGatewayId: internetGatewayId
            }).promise();

            console.log(`Deleted Internet Gateway : ${internetGatewayId}`);
        }
    }
    
    //----------- Internet Gateway ----------//
    
    /**
     * Get the Main Route Table for vpc
     */
    async getMainRouteTableId() {

        const tables = await this.getRouteTables();
        for (let table of tables) {
            for (let association of table.Associations) {
                if (association.Main) {
                    return table.RouteTableId;
                }
            }
        }
        return null;
    }

    /**
     * @return {Array<object>}
     */
    async getRouteTables() {

        const res = await this.ec2.describeRouteTables({
            Filters: [{Name: 'vpc-id', Values: [this.vpcId]}]
        }).promise();

        return res.RouteTables;
    }

    /**
     * @return {Promise<string>}
     */
    async createRouteTable() {

        const res = await this.ec2.createRouteTable({
            VpcId: this.vpcId
        }).promise();
        const routeTableId = res.RouteTable.RouteTableId;
        console.log(`Created Route Table : ${routeTableId}`);
        return routeTableId;
    }

    /**
     * @param {string} vpcId
     */
    async associateRouteTableToSubnet(routeTableId, subnetId) {

        const res = await this.ec2.associateRouteTable({
            RouteTableId: routeTableId,
            SubnetId: subnetId
        }).promise();
        console.log(`Associated route table ${routeTableId} to subnet ${subnetId}`);
    }

    /**
     * This hard codes cidr 0.0.0.0/0
     * @param {string} routeTableId
     * @param {string} gatewayId
     */
    async createRoute(routeTableId, gatewayId) {

        const res = await this.ec2.createRoute({
            RouteTableId: routeTableId,
            DestinationCidrBlock: '0.0.0.0/0',
            GatewayId: gatewayId
        }).promise();

        console.log(`Created route to gateway ${gatewayId} in route table ${routeTableId}`);
    }

    /**
     * This hard codes cidr 0.0.0.0/0
     * @param {string} routeTableId
     * @param {string} instanceId
     */
    async createRouteToInstance(routeTableId, instanceId) {

        const res = await this.ec2.createRoute({
            RouteTableId: routeTableId,
            DestinationCidrBlock: '0.0.0.0/0',
            InstanceId: instanceId
        }).promise();
        console.log(`Created route to instance ${instanceId} in route table ${routeTableId}`);
    }

    /**
     */
    async deleteVpcRouteTables() {
        const routeTables = await this.getRouteTables();
        for (let routeTable of routeTables) {
            let isMainTable = false;
            const routeTableId = routeTable.RouteTableId
            for (let association of routeTable.Associations) {
                if (!association.Main) {
                    await this.ec2.disassociateRouteTable({
                        AssociationId: association.RouteTableAssociationId
                    }).promise();
                    console.log(`Disassociate association id : ${association.RouteTableAssociationId}`);
                } else {
                    isMainTable = true;
                }
            }
            //cannot delete main table
            if (!isMainTable) {
                await this.ec2.deleteRouteTable({
                    RouteTableId: routeTableId
                }).promise();
                console.log(`Deleted RouteTable : ${routeTableId}`);
            } else {
                console.log(`Not Deleting Main Route Table : ${routeTableId}`);
            }
        }
    }

    
    //----------- Security Group ----------//
    
    /**
     * Create custom security group
     * @param {object} options
     */
    async createSecurityGroup(options) {

        const res = await this.ec2.createSecurityGroup({
            GroupName: options.name,
            Description: options.description,
            VpcId: this.vpcId
        }).promise();

        const securityGroupId = res.GroupId;

        const ingressRules = options.ingressRules || [];

        for (let rule of ingressRules) {
            let cidr = rule.cidr || '0.0.0.0/0';

            if (cidr === 'self') {
                cidr = securityGroupId;
            }

            if (!rule.port) {
                process.stderr.write('No port specified for security group ingress rule');
                continue;
            }

            let fromPort;
            let toPort;
            if (typeof rule.port === 'string' && rule.port.indexOf('-') !== -1) {
                const parts = rule.port.split('-');
                fromPort = parseInt(parts[0].trim());
                toPort = parseInt(parts[1].trim());
            } else {
                fromPort = rule.port;
                toPort = rule.port;
            }

            let params = {
                GroupId: securityGroupId,
            };
            
            let ipProtocol;
            if (typeof rule.cidr === 'string' && rule.cidr.startsWith('sg-')) {
                params.IpPermissions = [
                    {
                        FromPort: fromPort,
                        ToPort: toPort,
                        IpProtocol: 'tcp',
                        UserIdGroupPairs: [
                            {
                                GroupId: rule.cidr
                            }
                        ]
                    }
                ]
            } else {
                params.FromPort = fromPort;
                params.ToPort = toPort;
                params.CidrIp = cidr;
                params.IpProtocol = 'tcp';
            }

            await this.ec2.authorizeSecurityGroupIngress(params).promise();

        }

        const egressRules = options.egressRules || [];

        for (let rule of egressRules) {
            const cidr = rule.cidr || '0.0.0.0/0';
            if (!rule.port) {
                process.stderr.write('No port specified for security group egress rule');
                continue;
            }
            await this.ec2.authorizeSecurityGroupIngress({
                GroupId: securityGroupId,
                IpProtocol: 'tcp',
                FromPort: rule.port,
                ToPort: rule.port,
                CidrIp: cidr
            }).promise();

        }

        console.log(`Created Security Group : ${securityGroupId}`);

        return securityGroupId;
    }

    /**
     * Delete Security Group
     * @param {string} securityGroupName
     */
    async deleteSecurityGroup(securityGroupName) {
        const securityGroupId = await this.getSecurityGroupId(securityGroupName);
        if (securityGroupId !== null) {
            await this.ec2.deleteSecurityGroup({
                GroupId: securityGroupId
            }).promise();
            console.log(`Deleted Security Group : ${securityGroupId}`);
        } else {
            console.log(`No Security Group Found: ${securityGroupName}`);
        }
    }

    /**
     * @param {string} securityGroupName
     * @return {string} 
     */
    async getSecurityGroupId(securityGroupName) {

        const res = await this.ec2.describeSecurityGroups({
            Filters: [{Name: 'vpc-id', Values: [this.vpcId]}]
        }).promise();

        //there will be multipl groups (default is still there)
        for (let securityGroup of res.SecurityGroups) {
            if (securityGroup.GroupName === securityGroupName) {
                return securityGroup.GroupId;
            }
        }
        return null;
    }
    

    //----------- Nat ----------//

    /**
     * Add Nat instance to public subnet
     * @param {string} publicSubnetId
     * @param {object} natSecurityGroup
     * @return {Promise<string>}
     */
    async addNatInstance(publicSubnetId, natSecurityGroup) {

        const natSecurityGroupId = await this.createSecurityGroup(natSecurityGroup);

        const natInstanceId = await this.runInstance(NAT_INSTANCE_IMAGE_ID, publicSubnetId, natSecurityGroupId);
        await this.waitForInstanceStatus(natInstanceId, 'running');   
        //update main route table 
        const mainRouteTableId = await this.getMainRouteTableId();
        //cant add this until natInstance is running
        await this.createRouteToInstance(mainRouteTableId, natInstanceId);

    }

    /**
     * Delete Nat Instance in this vpc
     */
    async deleteNatInstance() {
        const res = await this.ec2.describeInstances({
            Filters: [{Name: 'image-id', Values: [NAT_INSTANCE_IMAGE_ID]}]
        }).promise();
        let instanceId;
        for (let reservation of res.Reservations) {
            for (let instance of reservation.Instances) {
                if (instance.VpcId === this.vpcId && instance.State.Name === 'running') {
                    instanceId = instance.InstanceId;
                    await this.ec2.terminateInstances({
                        InstanceIds: [instanceId]
                    }).promise();
                }
            }
        }
        if (instanceId) {
            await this.waitForInstanceStatus(instanceId, 'terminated');   
        }
    }
    
    //----------- Load Balancer  ----------//
    
    /**
     * @param {string} name
     * @param {Array<string>} subnets
     * @param {Array<string>} securityGroups
     */
    async createLoadBalancer(name, subnets, securityGroups) {

        const res = await this.elbv2.createLoadBalancer({
            Name: name,
            Subnets: subnets,
            SecurityGroups: securityGroups,
        }).promise();

        console.log(JSON.stringify(res));
        return res.LoadBalancers[0];
    }
    
    /**
     * @param {string} name
     */
    async deleteLoadBalancer(name) {

        const res = await this.elbv2.deleteLoadBalancer({
            Name: name,
        }).promise();

        console.log(JSON.stringify(res));
    }

    /**
     * @param {string} name
     */
    async createTargetGroup(name) {

        const res = await this.elbv2.createTargetGroup({
            Name: name,
            Port: 80,
            Protocol: 'HTTP',
            VpcId: this.vpcId,
        }).promise();

        console.log(JSON.stringify(res));
        return res.TargetGroups[0].TargetGroupArn;
    }

    /**
     * @param {string} targetGroupArn
     * @param {string} loadBalancerArn
     */
    async createListener(targetGroupArn, loadBalancerArn) {

        const res = await this.elbv2.createListener({
            DefaultActions: [
                {
                    TargetGroupArn: targetGroupArn,
                    Type: 'forward'
                }
            ],
            LoadBalancerArn: loadBalancerArn,
            Port: 80,
            Protocol: 'HTTP',
        }).promise();

        console.log(JSON.stringify(res));
    }

    /**
     * @param {string} name
     */
    async deleteListener(name) {

        const res = await this.elbv2.deleteListener({
            //ListenerArn: ???,
        }).promise();

        console.log(JSON.stringify(res));
    }
    
    //----------- Auto Scaling  ----------//

    /**
     * @param {string} targetGroupArn
     * @param {Array<string>} subnets
     * @return {string} 
     */
    async createAutoScalingGroup(targetGroupArn, subnets) {

        const res = await this.autoScaling.createAutoScalingGroup({
            AutoScalingGroupName: 'skeletonAutoScallingGroup', 
            LaunchConfigurationName: 'skeletonLaunchConfiguration', 
            MaxSize: 2, 
            MinSize: 1, 
            VPCZoneIdentifier: subnets.join(','),
            TargetGroupARNs: [
                targetGroupArn
            ], 
        }).promise();

        console.log(JSON.stringify(res));
    }

    /**
     */
    async deleteAutoScalingGroup(targetGroupArn, subnets) {

        const res = await this.autoScaling.deleteAutoScalingGroup({
            AutoScalingGroupName: 'skeletonAutoScallingGroup', 
        }).promise();

        console.log(JSON.stringify(res));
    }

    /**
     * @param {string} securityGroupId
     * @return {string} 
     */
    async createLaunchConfiguration(securityGroupId) {

        const res = await this.autoScaling.createLaunchConfiguration({
            IamInstanceProfile: 'ecsInstanceRole', 
            AssociatePublicIpAddress: true,
            ImageId: 'ami-29f80351',  //amazon-ecs-optimized for us-west-2
            InstanceType: 't2.micro', 
            LaunchConfigurationName: 'skeletonLaunchConfiguration', 
            SecurityGroups: [
                securityGroupId
            ],
            UserData: Buffer.from(`
            #!/bin/bash
            echo ECS_CLUSTER=skeletonCluster >> /etc/ecs/ecs.config
            `).toString('base64')

        }).promise();

        console.log(JSON.stringify(res));
    }

    /**
     * @param {string} securityGroupId
     * @return {string} 
     */
    async deleteLaunchConfiguration(securityGroupId) {

        const res = await this.autoScaling.deleteLaunchConfiguration({
            LaunchConfigurationName: 'skeletonLaunchConfiguration', 
        }).promise();

        console.log(JSON.stringify(res));
    }


    //----------- Cluster  ----------//
    
    /**
     * @param {string} name
     * @return {string} 
     */
    async createCluster(name) {

        const res = await this.ecs.createCluster({
            clusterName: name
        }).promise();

        console.log(JSON.stringify(res));
        return res.cluster.clusterArn;
    }
    
    /**
     * @param {string} name
     * @return {string} 
     */
    async deleteCluster(name) {

        const res = await this.ecs.deleteCluster({
            cluster: name
        }).promise();

        console.log(JSON.stringify(res));
        return res.cluster.clusterArn;
    }

    /* Services
     * Keep the deseried counts of tasks up
     * Deployments are riggered by change in desired count or by task definition change (updateService)
     * Schedulers use the minimumHealthyPercent (percentage of the desirec count) and maximumPercent parameters to determine deployment strategy
     * This allows you to deploy without changes to cluster capacity (desired count 4 with minimumHealthyPercent at 50% means the scheduler can stop 
     * free up 2 for new tasks
     * The maximumPercentage allows the schduler to not stop old instances to start up new tasks
     * When using a LB the LB tells whether the instance is healthy or not
     *
     * The scheduler determines task placement (which container instances can support your task definition)
     * It will try to balance across AZ
    */

    /**
     * @param {string} name
     * @param {number} desiredCount
     * @return {string} 
     */
    async createService(name, desiredCount, containerName, targetGroupArn) {

        const res = await this.ecs.createService({
            desiredCount: desiredCount,
            serviceName: name,
            cluster: 'skeletonCluster',
            taskDefinition: 'skeletonFamily',
            deploymentConfiguration: {
                maximumPercent: 200, 
                minimumHealthyPercent: 50
            }, 
            loadBalancers: [
                {
                    containerName: containerName,
                    containerPort:3000,
                    targetGroupArn: targetGroupArn
                }
            ],
            role: 'ecsServiceRole',
        }).promise();

        console.log(JSON.stringify(res));
        return res.service.serviceArn;
    }
    
    /**
     * @return {string} 
     */
    async updateService(name, taskDefinition) {

        const res = await this.ecs.updateService({
            cluster: 'skeletonCluster',
            service: name,
            taskDefinition: taskDefinition,
        }).promise();

        return res.service.serviceArn;
    }

    /**
     * @param {string} name
     * @return {string} 
     */
    async deleteService(name) {

        const res = await this.ecs.deleteService({
            service: name
        }).promise();

        console.log(JSON.stringify(res));
        return res.service.serviceArn;
    }

    /**
     * ecsInstanceRole
     * @param {string} containerDefinitionName
     * @param {string} dbHost
     * @param {string} commitHash
     * @return {object} 
     */
    async registerTaskDefinition(containerDefinitionName, dbHost, commitHash) {

        const res = await this.ecs.registerTaskDefinition({
            family: 'skeletonFamily',
            //taskRoleArn: 'ecsServiceRole',
            taskRoleArn: 'SkeletonECS',
            containerDefinitions: [
                {
                    name: containerDefinitionName,
                    cpu: 10,
                    essential: true,
                    image: 'pebble/skeleton:' + commitHash,
                    memory: 300,
                    portMappings: [
                        {
                            containerPort: 3000,
                            hostPort: 80,
                            protocol: 'tcp' 
                        },
                    ],
                    environment: [
                        {name: 'APP_TAG', value: commitHash},
                        {name: 'DB_HOST', value: dbHost},
                        {name: 'DB_USER', value: 'pebble'},
                        {name: 'DB_PASSWORD', value: 'remira99'}, //not recommended, need to find another way
                        {name: 'DYNAMO_ENDPOINT_URL', value: 'https://dynamodb.us-west-2.amazonaws.com'},
                    ]
                }
            ],
        }).promise();

        console.log(JSON.stringify(res));
        //return res.taskDefinition;
        return res.taskDefinition.family + ':' + res.taskDefinition.revision
    }
    
    /**
     * @param {string} taskDefinition
     * @return {string} 
     */
    async deregisterTaskDefinition(taskDefinition) {

        const res = await this.ecs.deleteService({
            taskDefinition: taskDefinition  //family:revision
        }).promise();

        console.log(JSON.stringify(res));
        return res.service.serviceArn;
    }

    //----------- Instance ----------//
    
    /**
     * @param {string} imageId
     * @param {string} cidr
     * @param {string} securityGroupName
     * @param {string} keyPair
     * @param {string} userData
     * @return {string}
     */
    async launchInstance(imageId, cidr, securityGroupName, keyPair, userData) {

        const securityGroupId = await this.getSecurityGroupId(securityGroupName);
        const subnetId = await this.getSubnetIdByCidr(cidr);
        const instanceId = await this.runInstance(imageId, subnetId, securityGroupId, keyPair, userData);
        const instance = await this.waitForInstanceStatus(instanceId, 'running');   
        return instance;
    }

    /**
     * @param {string} imageId
     * @param {string} subnetId
     * @param {string} securityGroupId
     * @param {string} keyPair
     * @param {string} userData
     * @return {string}
     */
    async runInstance(imageId, subnetId, securityGroupId, keyPair, userData) {

        const params = {
            ImageId: imageId,
            MaxCount: 1,
            MinCount: 1,
            InstanceType: 't2.micro',
            NetworkInterfaces: [
                {
                    DeviceIndex: 0,
                    SubnetId: subnetId,
                    Groups: [securityGroupId],
                    AssociatePublicIpAddress: true
                }
            ]
        };
        
        if (keyPair) {
            params.KeyName = keyPair; 
        }


        if (userData) {
            params.UserData = Buffer.from(userData).toString('base64');
        }

        const res = await this.ec2.runInstances(params).promise();
        const instanceId = res.Instances[0].InstanceId;
        console.log(`Created Instance: ${instanceId}`)
        return instanceId;
    }


    /**
     * @param {string} instanceId
     * @param {string} successStatus
     * @return {Promise<object>}
     */
    async waitForInstanceStatus(instanceId, successStatus) {
        return new Promise(async (resolve, reject) => {
            let id;
            id = setInterval(async () => {
                const res = await this.ec2.describeInstances({
                    InstanceIds: [instanceId]
                }).promise();
                const reservation = res.Reservations[0];
                const instance = reservation.Instances[0];
                const status = instance.State.Name;
                console.log(`Current Status: ${status} (waiting for ${successStatus})`);
                if (status === successStatus) {
                    clearInterval(id);
                    console.log(`Current Status: ${status}`);
                    console.log(`Private IP: ${instance.PrivateIpAddress}`);
                    if (instance.PublicIpAddress) {
                        console.log(`Public IP: ${instance.PublicIpAddress}`);
                    }
                    resolve(instance);
                }

            }, 5000);
        });
    }
}


