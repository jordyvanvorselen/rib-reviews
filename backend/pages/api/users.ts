import { ObjectId } from "mongodb";
import type { NextApiRequest, NextApiResponse } from "next";
import { use } from "next-api-route-middleware";
import clientPromise, { DATABASE_NAME } from "../../lib/mongodb";
import { authorize } from "../../middleware/authorization";
import { cors } from "../../middleware/cors";

type Error = { error: string };
type User = {
  _id?: ObjectId;
  email: string;
  photoUrl: string | null;
  displayName: string;
};

const handler = async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") return get(req, res);
  if (req.method === "POST") return post(req, res);
};

const get = async (req: NextApiRequest, res: NextApiResponse<User[]>) => {
  const db = (await clientPromise).db(DATABASE_NAME);
  const results = await db.collection("users").find({}).toArray();

  const users = results.map((r) => ({
    _id: r._id,
    email: r.email,
    photoUrl: r.photoUrl,
    displayName: r.displayName,
  }));

  res.status(200).json(users);
};

const post = async (req: NextApiRequest, res: NextApiResponse<User | Error>) => {
  const db = (await clientPromise).db(DATABASE_NAME);
  const { email, photoUrl, displayName } = req.body;

  if (!email || !displayName) {
    return res.status(422).json({ error: "Invalid request body." });
  }

  const user = { email, ...(photoUrl && { photoUrl }), displayName };

  const result = await db
    .collection("users")
    .findOneAndUpdate({ email }, { $set: user }, { upsert: true });

  res.status(200).json({
    ...user,
    _id: result.value?._id || result.lastErrorObject?.upserted,
  });
};

export default use(cors, authorize, handler);
