import { OAuth2Client } from "google-auth-library";
import type { NextApiRequest, NextApiResponse } from "next";
import { Middleware } from "next-api-route-middleware";

const CLIENT_ID =
  "20020247765-m67ihrajm4cjbiio5ht78f16gdib1hoh.apps.googleusercontent.com";
const client = new OAuth2Client(CLIENT_ID);

export const authorize: Middleware<NextApiRequest> = async (
  req: NextApiRequest,
  res: NextApiResponse,
  next: Function
) => {
  if (!req.headers.authorization) return unauthorized(res);

  await client
    .verifyIdToken({
      idToken: req.headers.authorization,
    })
    .then((ticket) => {
      const payload = ticket.getPayload();

      if (!payload || payload["hd"] !== "kabisa.nl") return unauthorized(res);

      return next();
    })
    .catch((_) => {
      return unauthorized(res);
    });
};

const unauthorized = (res: NextApiResponse) =>
  res.status(401).send({ message: "Unauthorized" });
