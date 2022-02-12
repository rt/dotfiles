import VpcService from './lib/ec2';
import rds from './lib/rds';
//import { getDynamicKeyPair } from './lib/ec2';

/**
 * This network consists of 
 * 1 Public Subnet with NAT instance
 * 2 Private Subnets (for db and failover)
 * 3 RDS Database
 * This class defines and puts constraints on what you can do
 */  

const command = process.argv[2];
const tag = process.argv[3];

const VPC_CIDR = '10.0.0.0/16';

const SUBNET_PUBLIC = {
    cidr: '10.0.1.0/24'
}

const SUBNET_PRIVATE_A = {
    cidr: '10.0.2.0/24',
    availabilityZone: 'us-west-2b'
}

const SUBNET_PRIVATE_B = {
    cidr: '10.0.3.0/24',
    availabilityZone: 'us-west-2c'
}

const APP_SERVER_IMAGE_ID = 'ami-6e1a0117';

const securityGroups = {
    WEB: {
        name: 'WebSecurityGroup', 
        description: 'Security group for web-tier',
        ingressRules: [
            { port: 80 }, { port: 3000 }, { port: 443 }, { port: 22 },
        ]
    },
    NAT: {
        name: 'NatSecurityGroup', 
        description: 'Security group for nat',
        ingressRules: [
            { cidr: '10.0.0.0/16', port: 80 }, { cidr:  '10.0.0.0/16', port: 443 }, { port: 22 },
        ],
        egressRules: [
            { port: 80 }, { port: 443 }, 
        ]
    },
    DB: {
        name: 'DbSecurityGroup', 
        description: 'Security group for database',
        ingressRules: [
            { port: 5433 },
        ]
    },
}

const dbSubnetGroup= {
    name: 'dbSubnetGroup',
    description: 'subnets to host db'
}

run();

async function run() {
    if (!command) {
        process.stderr.write('Must specify command (ex. npm run vpc create)');
        process.exit(1);;
    }

    let vpc;
    switch (command) {
        
       case 'create':
            await createNetwork(tag);
            break;

        case 'delete':
            await deleteNetwork(tag);
            break;
        
        case 'launchAppServer':
            vpc = new VpcService(await VpcService.getVpcIdByTag(tag));
            const keyPairName = 'MyKeyPair';
            //await getDynamicKeyPair(keyPairName);
            const instance = await vpc.launchAppServer(keyPairName);
            break;

        case 'createDb':
            vpc = new VpcService(await VpcService.getVpcIdByTag(tag));
            await createDb(vpc);
            break;

        case 'deleteDb':
            vpc = new VpcService(await VpcService.getVpcIdByTag(tag));
            await vpc.deleteDb();
            break;

    }
}

/**
 * Create Vpc, subnets and NAT
 * @param {string} tag
 */
async function createNetwork(tag) {

    try {
        const vpc = new VpcService();
        await vpc.createVpcWithTag(VPC_CIDR, tag);
    
        const publicSubnetId = await vpc.createPublicSubnet(SUBNET_PUBLIC);

        //two subnets require for rds db (three if multiAZ).  because it uses for backup/logs
        const privateSubnet1Id = await vpc.createSubnet(SUBNET_PRIVATE_A);
        const privateSubnet2Id = await vpc.createSubnet(SUBNET_PRIVATE_B); 
        const webSecurityGroupId = await vpc.createSecurityGroup(securityGroups.WEB);

        await vpc.addNatInstance(publicSubnetId, securityGroups.NAT);


    } catch(e) {

        console.error('Error Occurred: Deleting Stack ...');
        await deleteNetwork(tag);
        console.error('Failed: Stack has been deleted'); 
        throw e;
    }
}

/**
 * Delete Vpc
 */
async function deleteNetwork(tag) {
    const vpc = new VpcService(await VpcService.getVpcIdByTag(tag));

    //delete NAT
    await vpc.deleteNatInstance();
    await vpc.deleteSecurityGroup(securityGroups.NAT.name);

    //delete DB
    await rds.deleteDbSubnetGroup(dbSubnetGroup.name);
    await vpc.deleteSecurityGroup(securityGroups.DB.name);

    //delete Subnets
    await vpc.deleteSubnets();

    //delete Route Tables
    await vpc.deleteVpcRouteTables();

    //delete Other Security Groups
    await vpc.deleteSecurityGroup(securityGroups.WEB.name);

    //delete Internet Gateway
    await vpc.deleteInternetGateway();

    //delete Vpc
    await vpc.ec2.deleteVpc({VpcId: vpc.vpcId}).promise();
    
}



/**
 * Need ssh key for bitbucket (Linux)
 * ssh-keygen
 * need to start ssh agent on app server to 
 * ssh-agent /bin/bash
 * ssh-add ~/.ssh/id_rsa 
 * cat ~/.ssh/id_rsa.pub
 *
 *
 * curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
 * source ~/.bashrc
 * nvm install node
 *
 * git clone https://github.com/rt/skeleton.git
 * cd skeleton
 * npm install
 * DB_HOST=... DB_PORT=5433 DB_USER=pebble DB_PASSWORD=remira99 npm start
 */
//async function launchPrivateServer() {

//}

/**
 * sudo apt-get install postgresql-client
 *  psql -U pebble --host pebble.cy82mav2bmyb.us-west-2.rds.amazonaws.com --port 5433 --d postgres
*/
async function createDb(vpc) {
    const subnets = [];
    const subnetPrivateAId = await vpc.getSubnetIdByCidr(SUBNET_PRIVATE_A.cidr);
    subnets.push(subnetPrivateAId);
    const subnetPrivateBId = await vpc.getSubnetIdByCidr(SUBNET_PRIVATE_B.cidr);
    subnets.push(subnetPrivateBId);
    rds.createDbSubnetGroup(dbSubnetGroup, subnets); 

    const dbSecurityGroupId = await vpc.createSecurityGroup(securityGroups.DB);

    //the identifier must be unique to the account?
    await rds.createDbInstance('private-pebble', dbSubnetGroup.name, dbSecurityGroupId);
}

async function deleteDb() {
    await rds.deleteDbInstance('private-pebble');
}



