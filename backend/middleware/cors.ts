import Cors from 'cors';
import type { NextApiRequest, NextApiResponse } from "next";
import { Middleware } from "next-api-route-middleware";

export const cors: Middleware<NextApiRequest> = async (
  req: NextApiRequest,
  res: NextApiResponse,
  next: Function
) => {
  Cors({ methods: ['POST', 'GET', 'HEAD'] });

  return next();
};
