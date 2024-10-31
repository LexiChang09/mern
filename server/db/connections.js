import { MongoClient, ServerApiVersion } from "mongodb";

const uri = process.env.ATLAS_URI || "";
const client = new MongoClient(uri, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        depreciationErrors: true,
    },
});

try {
    //connect the client to the serer
    await client.connect();
    //send a ping to confirm a successful connection
    await client.db("admin").command({ ping: 1 });
    console.log("Pingged your deployment. You successfully connected to MongoDB!");
} catch (err) {
    console.error(err);
}

let db = client.db("employees");

export default db;
