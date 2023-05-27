import { ObjectId } from "mongodb";
import type { NextApiRequest, NextApiResponse } from "next";
import { use } from "next-api-route-middleware";
import clientPromise, { DATABASE_NAME } from "../../lib/mongodb";
import { authorize } from "../../middleware/authorization";
import { cors } from "../../middleware/cors";

type Error = { error: string };
type Venue = {
  _id?: ObjectId;
  location: string;
  name: string;
  website: string;
};

const handler = async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") return get(req, res);
  if (req.method === "POST") return post(req, res);
};

const get = async (req: NextApiRequest, res: NextApiResponse<Venue[]>) => {
  const db = (await clientPromise).db(DATABASE_NAME);
  const results = await db.collection("venues").find({}).toArray();

  const venues = results.map((r) => ({
    _id: r._id,
    name: r.name,
    location: r.location,
    website: r.website,
  }));

  res.status(200).json(venues);
};

const post = async (req: NextApiRequest, res: NextApiResponse<Venue | Error>) => {
  const db = (await clientPromise).db(DATABASE_NAME);

  const { name, location, website } = req.body;
  const venue = { name, location, website };

  if (!name || !location || !website) {
    return res.status(422).json({ error: "Invalid request body." });
  }

  db.collection("venues").insertOne(venue);

  res.status(200).json(venue);
};

export default use(cors, authorize, handler);
