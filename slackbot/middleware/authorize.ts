import crypto from "crypto";
import type { NextApiRequest, NextApiResponse } from "next";
import { Middleware } from "next-api-route-middleware";

require("dotenv").config();

export const authorize: Middleware<NextApiRequest> = async (
  req: NextApiRequest,
  res: NextApiResponse,
  next: Function
) => {
  // compute the basestring
  const baseStr = `v0:${req.headers["x-slack-request-timestamp"]}:${req.body}`;

  // extract the received signature from the request headers
  const receivedSignature = req.headers["x-slack-signature"];

  // compute the signature using the basestring
  // and hashing it using the signing secret
  // which can be stored as a environment variable
  const expectedSignature = `v0=${crypto
    .createHmac("sha256", process.env.SLACK_SIGNING_SECRET as string)
    .update(baseStr, "utf8")
    .digest("hex")}`;

  // match the two signatures
  if (expectedSignature !== receivedSignature) {
    return res.status(400).send("Error: Signature mismatch security error");
  }

  next();
};
