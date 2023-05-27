import { App } from "@slack/bolt";
import { NextApiRequest, NextApiResponse } from "next";
import { use } from "next-api-route-middleware";
import NextConnectReceiver from "utils/NextConnectReceiver";
import { authorize } from "../../middleware/authorize";
import * as api from "../../utils/api";

require("dotenv").config();

const receiver = new NextConnectReceiver({
  signingSecret: process.env.SLACK_SIGNING_SECRET || "invalid",
  // The `processBeforeResponse` option is required for all FaaS environments.
  // It allows Bolt methods (e.g. `app.message`) to handle a Slack request
  // before the Bolt framework responds to the request (e.g. `ack()`). This is
  // important because FaaS immediately terminate handlers after the response.
  processBeforeResponse: true,
});

const app = new App({
  token: process.env.SLACK_BOT_TOKEN,
  signingSecret: process.env.SLACK_SIGNING_SECRET,
  appToken: process.env.SLACK_APP_TOKEN,
  socketMode: false,
  developerMode: false,
  receiver: receiver,
});

app.command("/suggest", async ({ client, ack, logger, body }: any) => {
  await ack();

  try {
    await client.views.open({
      trigger_id: body.trigger_id,
      view: {
        type: "modal",
        callback_id: "view_1",
        title: {
          type: "plain_text",
          text: "Suggest a restaurant",
        },
        blocks: [
          {
            type: "input",
            block_id: "nameInput",
            label: {
              type: "plain_text",
              text: "Restaurant Name",
            },
            element: {
              type: "plain_text_input",
              action_id: "plain_input",
              placeholder: {
                type: "plain_text",
                text: 'e.g. "Denver"',
              },
            },
          },
          {
            type: "input",
            block_id: "locationInput",
            label: {
              type: "plain_text",
              text: "City",
            },
            element: {
              type: "plain_text_input",
              action_id: "plain_input",
              placeholder: {
                type: "plain_text",
                text: 'e.g. "Weert"',
              },
            },
          },
          {
            type: "input",
            block_id: "websiteInput",
            label: {
              type: "plain_text",
              text: "Website URL",
            },
            element: {
              type: "plain_text_input",
              action_id: "plain_input",
              placeholder: {
                type: "plain_text",
                text: 'e.g. "https://www.denver-restaurants.nl/"',
              },
            },
          },
        ],
        submit: {
          type: "plain_text",
          text: "Suggest",
        },
      },
    });
  } catch (error) {
    logger.error(error);
  }
});

app.view("view_1", async ({ body, ack, client }: any) => {
  await ack();

  const { nameInput, locationInput, websiteInput } = body.view.state.values;

  const name: string = nameInput.plain_input.value;
  const location: string = locationInput.plain_input.value;
  const website: string = websiteInput.plain_input.value;

  const response = await api.post("/venues", {
    name,
    location,
    website,
  });

  await api.post("/events", {
    venueId: response.data._id,
  });

  await client.chat.postMessage({
    channel: "eat-guild",
    text: `<@${body.user.id}> suggested to go to <${website}|${name}> in ${location}.`,
  });
});

const router = receiver.start();

router.get("/api", (req: NextApiRequest, res: NextApiResponse) => {
  res.status(200).json({
    test: true,
  });
});

export default use(authorize, router);
