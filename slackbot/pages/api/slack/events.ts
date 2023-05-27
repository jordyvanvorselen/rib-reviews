import { NextApiRequest, NextApiResponse } from "next";

export const config = {
  api: {
    bodyParser: false,
  },
};

const { appRunner } = require("./_app");

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method !== "POST") {
    res
      .status(405)
      .json({ error: "Sorry! This endpoint does not accept your requests." });
    return;
  }

  await appRunner.handleEvents(req, res);

  res.status(200).json({ challenge: req.body.challenge });
}
