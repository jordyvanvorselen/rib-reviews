import { ObjectId } from "mongodb";
import type { NextApiRequest, NextApiResponse } from "next";
import { use } from "next-api-route-middleware";
import clientPromise, { DATABASE_NAME } from "../../../lib/mongodb";
import { dateIsValid, documentExists } from "../../../lib/utils";
import { authorize } from "../../../middleware/authorization";
import { cors } from "../../../middleware/cors";

type Error = { error: string };
type Event = {
  _id?: ObjectId;
  date: string | null;
  venueId: ObjectId;
};

const handler = async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "PUT") return put(req, res);
};

const put = async (req: NextApiRequest, res: NextApiResponse<Event | Error>) => {
  const db = (await clientPromise).db(DATABASE_NAME);

  const { date } = req.body;
  const { id } = req.query;

  const eventExists = id && (await documentExists(db, "events", id as string));

  // Events can be created without a date, that means they are not planned yet.
  if (!id || !eventExists || !dateIsValid(date, true)) {
    console.log("eventExists", eventExists);
    console.log("dateIsValid", dateIsValid(date, true));
    console.log("id", id);
    return res.status(422).json({ error: "Invalid request body." });
  }

  const result = await db
    .collection("events")
    .findOneAndUpdate(
      { _id: new ObjectId(id as string) },
      { $set: { date } },
      { returnDocument: "after" }
    );

  const event = {
    _id: result?.value?._id,
    date: result?.value?.date,
    venueId: result?.value?.venueId,
  };

  res.status(200).json(event);
};

export default use(cors, authorize, handler);
