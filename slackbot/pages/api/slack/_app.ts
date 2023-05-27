import { AppRunner } from "@seratch_/bolt-http-runner";
import { App, FileInstallationStore, LogLevel } from "@slack/bolt";
import { FileStateStore } from "@slack/oauth";
import { Blocks, Elements, Modal } from "slack-block-builder";

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

const suggestionModal = () => {
  return Modal({ title: "Suggest a restaurant", callbackId: "suggestCallback" })
    .blocks(
      Blocks.Input({ label: "Restaurant Name", blockId: "nameInput" }).element(
        Elements.UserSelect({
          placeholder: 'e.g. "Denver"',
        })
      ),
      Blocks.Input({ label: "City", blockId: "locationInput" }).element(
        Elements.UserSelect({
          placeholder: 'e.g. "Weert"',
        })
      ),
      Blocks.Input({ label: "Website URL", blockId: "websiteInput" }).element(
        Elements.UserSelect({
          placeholder: 'e.g. "https://www.denver-restaurants.nl/"',
        })
      )
    )
    .submit("Suggest")
    .buildToJSON();
};

const app = new App(appRunner.appOptions());

app.command("/suggest", async ({ client, ack, logger, body }: any) => {
  try {
    await client.views.open({
      trigger_id: body.trigger_id,
      view: suggestionModal(),
    });
  } catch (error) {
    logger.error(error);
  } finally {
    await ack();
  }
});

app.view("suggestCallback", async ({ body, ack, client }: any) => {
  await ack();

  const { nameInput, locationInput, websiteInput } = body.view.state.values;

  const name: string = nameInput.plain_input.value;
  const location: string = locationInput.plain_input.value;
  const website: string = websiteInput.plain_input.value;

  const response = await api.post("/venues", { name, location, website });
  api.post("/events", { venueId: response.data._id });

  await client.chat.postMessage({
    channel: "eat-guild",
    text: `<@${body.user.id}> suggested to go to <${website}|${name}> in ${location}.`,
  });
});

appRunner.setup(app);
