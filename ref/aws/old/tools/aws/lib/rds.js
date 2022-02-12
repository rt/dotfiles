import AWS from 'aws-sdk';

function getRDS() {
    return new AWS.RDS({apiVersion: '2014-10-31', region: 'us-west-2'});
}
/**
 * @param {string} options
 * @param {Array<string>} subnetIds
 */
const createDbSubnetGroup = async function (options, subnetIds) {
    //let str = subnetIds.map(id => {return `"${id}"`;}).join(' ');
    const res = await getRDS().createDBSubnetGroup({
        DBSubnetGroupName: options.name,
        DBSubnetGroupDescription: options.description,
        SubnetIds: subnetIds
    }).promise();

    console.log(`Created Db Subnet Group ${options.name}`);
}

/**
 * @param {string} groupName
 */
const deleteDbSubnetGroup = async function(groupName) {

    try {
        const res = await getRDS().deleteDBSubnetGroup({
            DBSubnetGroupName: groupName,
        }).promise();
        console.log(`Deleted Db Subnet Group ${groupName}`);
    } catch (e) {
        console.log(`No Db Subnet Group Found ${groupName}`);
    }

}

/**
 * @param {string} dbInstanceIdentifier
 * @param {string} dbSubnetGroup
 * @param {string} dbSecurityGroupId
 */
const createDbInstance = async function(dbInstanceIdentifier, dbSubnetGroup, dbSecurityGroupId) {

    const params = {
        DBInstanceClass: 'db.t2.micro',
        DBInstanceIdentifier: dbInstanceIdentifier,
        DBName: 'skeleton',
        AllocatedStorage: 5,
        Engine: 'postgres',
        EngineVersion: '9.6.2',
        MasterUsername: 'pebble',
        MasterUserPassword: 'remira99',
        VpcSecurityGroupIds: [dbSecurityGroupId],
        DBSubnetGroupName: dbSubnetGroup,
        Port: 5433,
        MultiAZ: false,
        StorageType: 'standard'
    }
    const res = await getRDS().createDBInstance(params).promise();

    let instance = res.DBInstance;

    //get update instance
    instance = await waitForDbInstanceStatus(dbInstanceIdentifier, 'available');

    console.log(JSON.stringify(instance))
    console.log(`Created and Ready to use, Db Instance ${instance.Engine} ${instance.Endpoint.Address}:${instance.Endpoint.Port}`);
    return instance;
}

/**
 * @param {string} dbInstanceIdentifier
 */
const getDbInstance = async function(dbInstanceIdentifier) {
    const res = await getRDS().describeDBInstances({
        DBInstanceIdentifier: dbInstanceIdentifier,
    }).promise();
    return res.DBInstances[0];
}

/**
 * @param {string} dbInstanceIdentifier
 */
const deleteDbInstance = async function(dbInstanceIdentifier) {

    const res = await getRDS().deleteDBInstance({
        DBInstanceIdentifier: dbInstanceIdentifier,
        //FinalDBSnapshotIdentifier: 'pebble-final',
        SkipFinalSnapshot: true
    }).promise();
    await waitForDbInstanceStatus(dbInstanceIdentifier, 'stopped');
    console.log(`Deleted Database ${dbInstanceIdentifier}`);
}

/**
 * @param {string} dbInstanceIdentifier
 * @param {string} successStatus
 */
const waitForDbInstanceStatus = async function(dbInstanceIdentifier, successStatus) {
    return new Promise(async (resolve, reject) => {
        let id;
        id = setInterval(async () => {
            const res = await getRDS().describeDBInstances({
                DBInstanceIdentifier: dbInstanceIdentifier
            }).promise();
            const status = res.DBInstances[0].DBInstanceStatus;
            console.log(`Current Status: ${status} (waiting for ${successStatus})`);
            if (status === successStatus) {
                clearInterval(id);
                resolve(res.DBInstances[0]);
            }
            
        }, 5000);
    });
}

export default {
    createDbSubnetGroup,
    deleteDbSubnetGroup,
    createDbInstance,
    deleteDbInstance,
    getDbInstance
}
