import AWS from 'aws-sdk';

function getDynamoDb(endpoint) {

    const options = {
    };
    //if (endpoint) {
        options.region = 'localhost';
        options.endpoint = new AWS.Endpoint('http://localhost:8000')
    //}
    return new AWS.DynamoDB(options);
}
/**
 * @param {string} options
 */
const createTable = async function (options) {
    
    const res = await getDynamoDb().createTable(options).promise();
    return res;
}
/**
 * @param {string} options
 * @param {Array<string>} subnetIds
 */
const listTables = async function (options, subnetIds) {

    const res = await getDynamoDb().listTables().promise();
    return res;
}


export default {
    listTables,
    createTable
}
