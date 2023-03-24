import { OAuth2Client } from "google-auth-library";
import type { NextApiRequest, NextApiResponse } from "next";
import { Middleware } from "next-api-route-middleware";

const CLIENT_ID = "";
const client = new OAuth2Client(CLIENT_ID);

export const authorize: Middleware<NextApiRequest> = async (
  req: NextApiRequest,
  res: NextApiResponse,
  next: Function
) => {
  if (!req.headers.authorization) return unauthorized(res);

  const ticket = await client.verifyIdToken({
    idToken: req.headers.authorization,
    audience: CLIENT_ID,
  });

  const payload = ticket.getPayload();

  if (!payload) return unauthorized(res);

  const domain = payload["hd"];

  if (domain !== "@kabisa.nl") return unauthorized(res);

  return next();
};

const unauthorized = (res: NextApiResponse) =>
  res.status(401).send({ message: "Unauthorized" });
