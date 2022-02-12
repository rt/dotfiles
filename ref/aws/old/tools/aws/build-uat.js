import path from 'path';
import { readFile } from '../utils';
//import { getDynamicKeyPair } from './lib/ec2';
import VpcService from './lib/ec2';
import rds from './lib/rds';

const command = process.argv[2];

const tags = {
    UAT: 'UAT', 
    PROD: 'PROD'
};

const VPC_CIDR = '10.0.0.0/16';

const SUBNET_ECS_A = {
    cidr: '10.0.4.0/24',
    availabilityZone: 'us-west-2b'
}

const SUBNET_ECS_B = {
    cidr: '10.0.5.0/24',
    availabilityZone: 'us-west-2c'
}

const securityGroups = {
    DB: {
        name: 'DbSecurityGroup', 
        description: 'Security group for database',
        ingressRules: [
            { port: 5433 },
        ]
    },
    LB: {
        name: 'LbSecurityGroup', 
        description: 'Security group for load balancer',
        ingressRules: [
            { port: 80 },
        ]
    },
    ECS: {
        name: 'ECSSecurityGroup', 
        description: 'Security group for ecs instances',
    },
    MANAGER: {
        name: 'Manager', 
        description:  'Security group for times need to access nodes on the network',
        ingressRules: [
           { port: 22 },
        ]
    },
    MIGRATE: {
        name: 'MigrateManager', 
        description:  'Security group for times need to access nodes on the network',
        ingressRules: [
           { port: 22 }, { port: 5433 },
        ]
    },
}

const dbSubnetGroup= {
    name: 'dbSubnetGroup',
    description: 'subnets to host db'
}

const APP_SERVER_IMAGE_ID = 'ami-6e1a0117';

const SSH_KEY_PAIR = 'MyKeyPair';

run();

/*
 * The purpose of this script is to create/delete UAT dynamically so that it
 * doesnt always have to be up
 */

async function run() {
    if (!command) {
        process.stderr.write('Must specify command (ex. npm run build-uat create)');
        process.exit(1);;
    }

    let vpc;
    switch (command) {

        case 'create':
            const commitHash = process.argv[3];
            if (!commitHash) {
                console.log('Need to specify commit');
                return;
            }
            await createNetwork(tags.UAT, commitHash);
            break;
        
        //case 'createDb':
            //vpc = new VpcService(await VpcService.getVpcIdByTag(tag));
            //await vpc.createDb();
            //break;
        
        //case 'delete':
            //vpc = new VpcService(await VpcService.getVpcIdByTag(tag));
            //await vpc.deleteDb();
            //break;

        case 'launchManager': 
            vpc = new VpcService(await VpcService.getVpcIdByTag(tags.UAT));
            const instance = await vpc.launchInstance(
                APP_SERVER_IMAGE_ID, 
                SUBNET_ECS_A.cidr, 
                securityGroups.MANAGER.name,
                SSH_KEY_PAIR
            );
            
            break;

            //use to manually migrate db
        case 'launchMigrateService':
            await launchMigrateService(tags.UAT, process.argv[3]);
            break;
        
            //use to manually update app
        case 'updateService':
            await updateClusterService(tags.UAT, process.argv[3]);
            break;
    }
}

/**
 * Create UAT or Prod
 * @param {string} tag
 * @param {string} commitHash
 */
async function createNetwork(tag, commitHash) {

    try {
        const vpc = new VpcService();
        await vpc.createVpcWithTag(VPC_CIDR, tag);
    
        //create web subnets
        const ecsSubnet1Id = await vpc.createSubnet(SUBNET_ECS_A);
        const ecsSubnet2Id = await vpc.createSubnet(SUBNET_ECS_B); 

        const subnets = [ecsSubnet1Id, ecsSubnet2Id];

        await vpc.createPublicLayer(subnets);

        await vpc.createSecurityGroup(securityGroups.MANAGER);
        await vpc.createSecurityGroup(securityGroups.MIGRATE);

        //---------- LB and Auto Scaling

        //create load balancer security groups
        const loadBalancerSecurityGroupId = await vpc.createSecurityGroup(securityGroups.LB);
        //create load balancer
        const loadBalancer = await vpc.createLoadBalancer('skeletonLB', subnets, [loadBalancerSecurityGroupId]);

        //create load balancer target group
        const targetGroupArn = await vpc.createTargetGroup(securityGroups.LB.name + 'TargetGroup');

        //create load balancer listeer
        await vpc.createListener(targetGroupArn, loadBalancer.LoadBalancerArn);

        //add rule to this with loadBalancerSecurityGroupId
        securityGroups.ECS.ingressRules = [
            {
                port: '0-65255',
                cidr: loadBalancerSecurityGroupId
            }
        ];
        const ecsSecurityGroupId = await vpc.createSecurityGroup(securityGroups.ECS);

        //create launch configuration
        await vpc.createLaunchConfiguration(ecsSecurityGroupId);

        //create auto scaling group
        await vpc.createAutoScalingGroup(targetGroupArn, subnets);

        //---------- DB
        //create db
        const dbInstance = await createDb(vpc);

        //migrate
        await launchMigrateService(tags.UAT, commitHash);
        
        //---------- Cluster
        //create cluster
        await vpc.createCluster('skeletonCluster');
        
        //create task definition
        await vpc.registerTaskDefinition('skeletonContainerDefinition', dbInstance.Endpoint.Address, commitHash);
        
        //create service
        await vpc.createService('skeletonService', 1, 'skeletonContainerDefinition', targetGroupArn);

        console.log('Available at ' + loadBalancer.DNSName);

    } catch(e) {

        //console.error('Error Occurred: Deleting Stack ...');
        //await this.deleteNetwork();
        //console.error('Failed: Stack has been deleted'); 
        throw e;
    }
}

/**
 * Delete Vpc
 */
async function deleteNetwork() {

    ////delete NAT
    //await this.deleteNatInstance();
    //await this.deleteSecurityGroup(securityGroups.NAT.name);

    ////delete DB
    //await rds.deleteDbSubnetGroup(dbSubnetGroup.name);
    //await this.deleteSecurityGroup(securityGroups.DB.name);

    ////delete Subnets
    //await this.deleteSubnets();

    ////delete Route Tables
    //await this.deleteVpcRouteTables();

    ////delete Other Security Groups
    //await this.deleteSecurityGroup(securityGroups.WEB.name);

    ////delete Internet Gateway
    //await this.deleteInternetGateway();

    
    //await this.deleteService('skeletonService');

    //await this.deleteAutoScalingGroup();
    //await this.deleteLaunchConfiguration();
    
    ////await this.deleteListener(listnerArn);
    //await this.deleteLoadBalancer('skeletonLB');
    
    //await this.deleteCluster('skeletonCluster');

    ////delete Vpc
    //await this.ec2.deleteVpc({VpcId: this.vpcId}).promise();
    
}

/**
 * sudo apt-get install postgresql-client
 * psql -U pebble --host pebble.cy82mav2bmyb.us-west-2.rds.amazonaws.com --port 5433 --d postgres
 */
async function createDb(vpc) {
    const subnets = [];
    const subnetAId = await vpc.getSubnetIdByCidr(SUBNET_ECS_A.cidr);
    subnets.push(subnetAId);
    const subnetBId = await vpc.getSubnetIdByCidr(SUBNET_ECS_B.cidr);
    subnets.push(subnetBId);
    rds.createDbSubnetGroup(dbSubnetGroup, subnets); 

    const dbSecurityGroupId = await vpc.createSecurityGroup(securityGroups.DB);

    //the identifier must be unique to the account?
    const dbInstance = await rds.createDbInstance('skeleton-uat', dbSubnetGroup.name, dbSecurityGroupId);
    return dbInstance;
}

async function deleteDb() {
    await rds.deleteDbInstance('skeleton-uat');
}


async function updateClusterService(tag, commit) {
    if (!tag || !commit) {
        console.log('Must specify tag, database url, and commit');
        return;
    }
    const dbInstance =await rds.getDbInstance('skeleton-uat');
    const dbHost = dbInstance.Endpoint.Address;

    let vpc = new VpcService(await VpcService.getVpcIdByTag(tag));
    await vpc.registerTaskDefinition('skeletonContainerDefinition', dbHost, commit);
    await vpc.updateService('skeletonService', 'skeletonFamily');
}

async function launchMigrateService(tag, commit) {
    if (!tag || !commit) {
        console.log('Must specify tag and commit');
        return;
    }

    const dbInstance = await rds.getDbInstance('skeleton-uat');
    const dbHost = dbInstance.Endpoint.Address;

    let fp = path.join(__dirname, 'user-data','migrate.sh');
    let userData = await readFile(fp);
    userData = userData.replace('${DB-HOST}', dbHost); 
    userData = userData.replace(/\$\{COMMIT\}/g, commit); 

    let vpc = new VpcService(await VpcService.getVpcIdByTag(tag));
    //launch instance to migrate database
    await vpc.launchInstance(
        APP_SERVER_IMAGE_ID, 
        SUBNET_ECS_A.cidr, 
        securityGroups.MIGRATE.name,
        SSH_KEY_PAIR,
        userData
    );

}


