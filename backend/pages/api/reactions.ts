import { ObjectId } from "mongodb";
import type { NextApiRequest, NextApiResponse } from "next";
import { use } from "next-api-route-middleware";
import clientPromise from "../../lib/mongodb";
import { authorize } from "../../middleware/authorization";
import { cors } from "../../middleware/cors";

type Error = { error: string };
type Reaction = {
  _id?: ObjectId;
  emoji: string;
  userIds: [ObjectId];
  reviewId: [ObjectId];
};

const handler = async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") return get(req, res);
  if (req.method === "PUT") return put(req, res);
};

const get = async (req: NextApiRequest, res: NextApiResponse<Reaction[]>) => {
  const db = (await clientPromise).db();
  const results = await db.collection("reactions").find({}).toArray();

  const reactions = results.map((r) => ({
    _id: r._id,
    emoji: r.emoji,
    userIds: r.userIds,
    reviewId: r.reviewId,
  }));

  res.status(200).json(reactions);
};

const put = async (req: NextApiRequest, res: NextApiResponse<null | Reaction | Error>) => {
  const db = (await clientPromise).db();
  const { emoji, userIds, reviewId } = req.body;

  if (!emoji || !userIds || !reviewId) {
    return res.status(422).json({ error: "Invalid request body." });
  }

  const reaction = { emoji, userIds, reviewId };

  if (userIds.length === 0) {
    await db.collection("reactions").findOneAndDelete({ emoji, reviewId });

    return res.status(204).send(null);
  }

  const result = await db
    .collection("reactions")
    .findOneAndUpdate({ emoji, reviewId }, { $set: reaction }, { upsert: true });

  res.status(200).json({
    ...reaction,
    _id: result.value?._id || result.lastErrorObject?.upserted,
  });
};

export default use(cors, authorize, handler);
