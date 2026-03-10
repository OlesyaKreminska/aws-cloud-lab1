const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(client);

const replaceAll = (str, find, replace) => {
    return str.replace(new RegExp(find, "g"), replace);
};

exports.handler = async (event) => {
    try {
        const id = replaceAll(event.title, " ", "-").toLowerCase();
        const courseItem = {
            id: id,
            title: event.title,
            watchHref: `http://www.pluralsight.com/courses/${id}`,
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
