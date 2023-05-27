import { AppRunner } from "@seratch_/bolt-http-runner";
import { App, FileInstallationStore, LogLevel } from "@slack/bolt";
import { FileStateStore } from "@slack/oauth";

import * as api from "../../../utils/api";

require("dotenv").config();

export const appRunner = new AppRunner({
  logLevel: LogLevel.DEBUG,
  token: process.env.SLACK_BOT_TOKEN,
  signingSecret: process.env.SLACK_SIGNING_SECRET as string,
  clientId: process.env.SLACK_CLIENT_ID,
  clientSecret: process.env.SLACK_CLIENT_SECRET,
  processBeforeResponse: true,
  scopes: ["commands", "chat:write", "app_mentions:read"],
  installationStore: new FileInstallationStore(),
  installerOptions: {
    stateStore: new FileStateStore({}),
  },
});

const app = new App(appRunner.appOptions());

app.command("/suggest", async ({ client, ack, logger, body }: any) => {
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
  } finally {
    await ack();
  }
});

app.view("view_1", async ({ body, ack, client }: any) => {
  const { nameInput, locationInput, websiteInput } = body.view.state.values;

  const name: string = nameInput.plain_input.value;
  const location: string = locationInput.plain_input.value;
  const website: string = websiteInput.plain_input.value;

  const response = await api.post("/venues", { name, location, website });
  await api.post("/events", { venueId: response.data._id });

  await client.chat.postMessage({
    channel: "eat-guild",
    text: `<@${body.user.id}> suggested to go to <${website}|${name}> in ${location}.`,
  });

  await ack();
});

appRunner.setup(app);
