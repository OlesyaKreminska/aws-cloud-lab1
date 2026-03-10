const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");
const crypto = require("crypto");

const client = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(client);
const tableName = process.env.TABLE_NAME;

exports.handler = async (event) => {
    try {
        // Якщо ми запускаємо тест вручну, беремо дані з event
        const body = event.body ? JSON.parse(event.body) : event;
        
        const userItem = {
            id: body.id || crypto.randomUUID(),
            name: body.name || "Без імені",
            role: body.role || "Студент"
        };

        await dynamo.send(new PutCommand({
            TableName: tableName,
            Item: userItem
        }));
        
        return {
            statusCode: 200,
            body: JSON.stringify({ message: "Користувача успішно збережено!", user: userItem }),
        };
    } catch (err) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: err.message }),
        };
    }
};
