import type { NextApiRequest, NextApiResponse } from "next";
import { use } from "next-api-route-middleware";
import clientPromise, { DATABASE_NAME } from "../../../lib/mongodb";
import { authorize } from "../../../middleware/authorization";
import { cors } from "../../../middleware/cors";

type Error = { error: string };
type Text = {
  type: string;
  text: string;
};

type Option = {
  text: Text;
  value: string;
};

type OptionsResponse = {
  options: Option[];
};

const handler = async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "POST") return post(req, res);
};

const post = async (req: NextApiRequest, res: NextApiResponse<OptionsResponse | Error>) => {
  const db = (await clientPromise).db(DATABASE_NAME);

  const options = {
    options: [
      {
        text: {
          type: "plain_text",
          text: "*this is plain_text text*",
        },
        value: "value-0",
      },
      {
        text: {
          type: "plain_text",
          text: "*this is plain_text text*",
        },
        value: "value-1",
      },
      {
        text: {
          type: "plain_text",
          text: "*this is plain_text text*",
        },
        value: "value-2",
      },
    ],
  };

  res.status(200).json(options);
};

export default use(cors, authorize, handler);
