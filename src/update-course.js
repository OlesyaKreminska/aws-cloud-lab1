const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
    try {
        const courseItem = {
            id: event.id,
            title: event.title,
            watchHref: event.watchHref,
            authorId: event.authorId,
            length: event.length,
            category: event.category
        };
        await dynamo.send(new PutCommand({
            TableName: process.env.TABLE_NAME,
            Item: courseItem
        }));
        return courseItem;
    } catch (err) {
        console.error(err);
        throw new Error(err);
    }
};
