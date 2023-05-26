import { MongoClient } from "mongodb";

if (!process.env.MONGODB_URI) {
  throw new Error('Invalid/Missing environment variable: "MONGODB_URI"');
}

if (!process.env.DATABASE_NAME) {
  throw new Error('Invalid/Missing environment variable: "DATABASE_NAME"');
}

if (!process.env.SLACKBOT_API_TOKEN) {
  throw new Error('Invalid/Missing environment variable: "SLACKBOT_API_TOKEN"');
}

const uri = process.env.MONGODB_URI;
const options = {};

let client;
let clientPromise: Promise<MongoClient>;

client = new MongoClient(uri, options);
clientPromise = client.connect();

export const DATABASE_NAME = process.env.DATABASE_NAME;

// Export a module-scoped MongoClient promise. By doing this in a
// separate module, the client can be shared across functions.
export default clientPromise;
