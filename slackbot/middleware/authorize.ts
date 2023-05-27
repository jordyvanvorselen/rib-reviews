import type { NextApiRequest, NextApiResponse } from "next";
import { Middleware } from "next-api-route-middleware";

require("dotenv").config();

export const authorize: Middleware<NextApiRequest> = async (
  req: NextApiRequest,
  res: NextApiResponse,
  next: Function
) => {
  return next();
};
