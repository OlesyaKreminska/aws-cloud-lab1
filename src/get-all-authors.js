const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, ScanCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
    try {
        const result = await dynamo.send(new ScanCommand({ 
            TableName: process.env.TABLE_NAME 
        }));
        
        // Повертаємо сирий масив даних (так вимагає методичка для API)
        return result.Items;
    } catch (err) {
        console.error(err);
        throw new Error(err);
    }
};
