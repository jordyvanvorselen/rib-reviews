import { OAuth2Client } from "google-auth-library";
import type { NextApiRequest, NextApiResponse } from "next";
import { Middleware } from "next-api-route-middleware";

const CLIENT_ID =
  "970203920402-s9f86krqagtivv1uqkkkn0qnmj3lv9ci.apps.googleusercontent.com";
const client = new OAuth2Client(CLIENT_ID);

export const authorize: Middleware<NextApiRequest> = async (
  req: NextApiRequest,
  res: NextApiResponse,
  next: Function
) => {
  if (!req.headers.authorization) return unauthorized(res);

  const ticket = await client
    .verifyIdToken({
      idToken: req.headers.authorization,
    })
    .catch((err) => console.error(err));

  const payload = ticket?.getPayload();

  if (!payload || payload["hd"] !== "kabisa.nl") return unauthorized(res);

  return next();
};

const unauthorized = (res: NextApiResponse) =>
  res.status(401).send({ message: "Unauthorized" });
