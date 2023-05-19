import { ObjectId } from "mongodb";
import type { NextApiRequest, NextApiResponse } from "next";
import { use } from "next-api-route-middleware";
import clientPromise, { DATABASE_NAME } from "../../lib/mongodb";
import { dateIsValid, documentExists } from "../../lib/utils";
import { authorize } from "../../middleware/authorization";
import { cors } from "../../middleware/cors";

type Error = { error: string };
type Review = {
  _id?: ObjectId;
  rating: number;
  text: string;
  createdAt: string;
  userId: ObjectId;
  eventId: ObjectId;
};

const handler = async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") return get(req, res);
  if (req.method === "POST") return post(req, res);
};

const get = async (req: NextApiRequest, res: NextApiResponse<Review[]>) => {
  const db = (await clientPromise).db(DATABASE_NAME);
  const results = await db.collection("reviews").find({}).toArray();

  const reviews = results.map((r) => ({
    _id: r._id,
    rating: r.rating,
    text: r.text,
    createdAt: r.createdAt,
    userId: r.userId,
    eventId: r.eventId,
  }));

  res.status(200).json(reviews);
};

const post = async (
  req: NextApiRequest,
  res: NextApiResponse<Review | Error>
) => {
  const db = (await clientPromise).db(DATABASE_NAME);

  const { rating, text, createdAt, userId, eventId } = req.body;

  const userExists = await documentExists(db, "users", userId);
  const eventExists = await documentExists(db, "events", eventId);

  if (
    !rating ||
    rating < 0 ||
    rating > 5 ||
    !text ||
    !dateIsValid(createdAt) ||
    !userExists ||
    !eventExists
  ) {
    return res.status(422).json({ error: "Invalid request body." });
  }

  const review = {
    rating,
    text,
    createdAt,
    userId: new ObjectId(userId),
    eventId: new ObjectId(eventId),
  };

  db.collection("reviews").insertOne(review);

  res.status(200).json(review);
};

export default use(cors, authorize, handler);
