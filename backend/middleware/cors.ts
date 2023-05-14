import type { NextApiRequest, NextApiResponse } from "next";
import { Middleware } from "next-api-route-middleware";

export const cors: Middleware<NextApiRequest> = async (
  req: NextApiRequest,
  res: NextApiResponse,
  next: Function
) => {
  res.setHeader('Access-Control-Allow-Origin', '*');

  return next();
};
