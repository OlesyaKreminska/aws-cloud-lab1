const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, GetCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
    try {
        const result = await dynamo.send(new GetCommand({
            TableName: process.env.TABLE_NAME,
            Key: { id: event.id }
        }));
        return result.Item;
    } catch (err) {
        console.error(err);
        throw new Error(err);
    }
};
