import { NextApiRequest, NextApiResponse } from "next";
import { appRunner } from "./_app";

export const config = {
  api: {
    bodyParser: false,
  },
  runtime: "edge",
  regions: ["dub1"],
};

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method !== "POST") {
    return res
      .status(405)
      .json({ error: "Sorry! This endpoint does not accept your requests." });
  }

  await appRunner.handleEvents(req, res);
}
