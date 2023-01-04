import type { NextApiRequest, NextApiResponse } from "next";
import { Middleware } from "next-api-route-middleware";

export const authorize: Middleware<NextApiRequest> = async (
  req: NextApiRequest,
  res: NextApiResponse,
  next: Function
) => {
  if (req.headers.authorization === process.env.API_KEY) {
    return next();
  }

  return res.status(401).send({ message: "Unauthorized" });
};
