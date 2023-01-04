import { ObjectId } from "mongodb";
import type { NextApiRequest, NextApiResponse } from "next";
import { use } from "next-api-route-middleware";
import clientPromise from "../../lib/mongodb";
import { authorize } from "../../middleware/authorization";

type Error = { error: string };
type Event = {
  _id?: ObjectId;
  date: string | null;
  venueId: ObjectId;
};

const handler = async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") return get(req, res);
  if (req.method === "POST") return post(req, res);
};

const get = async (req: NextApiRequest, res: NextApiResponse<Event[]>) => {
  const db = (await clientPromise).db("rib-reviews");
  const results = await db.collection("events").find({}).toArray();

  const events = results.map((r) => ({
    _id: r._id,
    date: r.date,
    venueId: r.venueId,
  }));

  res.status(200).json(events);
};

const post = async (
  req: NextApiRequest,
  res: NextApiResponse<Event | Error>
) => {
  const db = (await clientPromise).db("rib-reviews");

  const { date, venueId } = req.body;

  const venueExists =
    ObjectId.isValid(venueId) &&
    (
      await db
        .collection("venues")
        .find({ _id: new ObjectId(venueId) })
        .toArray()
    ).length > 0;

  if (!venueId || !venueExists || !dateIsValid(date)) {
    return res.status(422).json({ error: "Invalid request body." });
  }

  const event = { date, venueId: new ObjectId(venueId) };

  db.collection("events").insertOne(event);

  res.status(200).json(event);
};

const dateIsValid = (date: string) => {
  // Events can be created without a date, that means they are not planned yet.
  if (!date) return true;
  if (Date.parse(date) > 0) return true;

  return false;
};

export default use(authorize, handler);
