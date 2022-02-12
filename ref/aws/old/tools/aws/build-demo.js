//import { getDynamicKeyPair } from './lib/ec2';
import VpcService from './lib/ec2';

const command = process.argv[2];
const tag = process.argv[3];

const VPC_CIDR = '10.0.0.0/16';

const APP_SERVER_IMAGE_ID = 'ami-6e1a0117';

const SUBNET_PUBLIC = {
    cidr: '10.0.1.0/24',
    availabilityZone: 'us-west-2a'
}

const securityGroups = {
    WEB: {
        name: 'WebSecurityGroup', 
        description:  'Security group for web-tier',
        ingressRules: [
            { port: 80 }, { port: 3000 }, { port: 443 }, { port: 22 },
        ]
    },
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

            const instance = await vpc.launchInstance(APP_SERVER_IMAGE_ID, SUBNET_PUBLIC.cidr, securityGroups.WEB.name, keyPairName);
            //console.log(`Success! You can now ssh in with the following command.`);
            //console.log(`ssh -i ${keyPairName}.pem ubuntu@${ip}`);
            break;

    }
}

/**
 * @params {string} tag
 */
async function createNetwork(tag) {

    try {

        const vpc = new VpcService();
        await vpc.createVpcWithTag(VPC_CIDR, tag);
        
        //create single subnet
        await vpc.createSubnet(SUBNET_PUBLIC);

        //create internet gateway
        const internetGatewayId = await vpc.createInternetGateway();

        //add route to internet gateway in main table
        const routeTableId = await vpc.getMainRouteTableId();
        await vpc.createRoute(routeTableId, internetGatewayId);

        console.log(`Created Route in Main Table (${routeTableId}) to Gateway : ${internetGatewayId}`);

        //create SG for web tier instances?
        await vpc.createSecurityGroup(securityGroups.WEB);

    } catch(e) {

        console.error('Error Occurred: Deleting Stack ...');
        await deleteNetwork(tag);
        console.error('Failed: Stack has been deleted'); 
        throw e;

    }
}

/**
 * @param {string} tag
 */
async function deleteNetwork(tag) {
    const vpc = new VpcService(await VpcService.getVpcIdByTag(tag));
    await vpc.deleteSecurityGroup(securityGroups.WEB.name);
    await vpc.deleteVpc();
}


