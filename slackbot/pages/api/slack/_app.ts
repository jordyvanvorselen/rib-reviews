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
        Elements.TextInput({ actionId: "input" }).placeholder('e.g. "Denver"')
      ),
      Blocks.Input({ label: "City", blockId: "locationInput" }).element(
        Elements.TextInput({ actionId: "input" }).placeholder('e.g. "Weert"')
      ),
      Blocks.Input({ label: "Website URL", blockId: "websiteInput" }).element(
        Elements.TextInput({ actionId: "input" }).placeholder(
          'e.g. "https://www.denver-restaurants.nl/'
        )
      )
    )
    .submit("Suggest")
    .buildToJSON();
};

const planEventModal = () => {
  return Modal({ title: "Plan the next event", callbackId: "planEvent" })
    .blocks(
      Blocks.Input({ label: "Where will we go?", blockId: "eventInput" }).element(
        Elements.ExternalSelect({ actionId: "eventSelect" }).minQueryLength(0)
      ),
      Blocks.Input({ label: "And when?", blockId: "dateInput" }).element(
        Elements.DateTimePicker({ actionId: "input" })
      )
    )
    .submit("Plan")
    .buildToJSON();
};

const app = new App(appRunner.appOptions());

app.command("/suggest", async ({ client, ack, logger, body }: any) => {
  await ack();

  try {
    await client.views.open({
      trigger_id: body.trigger_id,
      view: suggestionModal(),
    });
  } catch (error) {
    logger.error(error);
  }
});

app.command("/plan", async ({ client, ack, logger, body }: any) => {
  await ack();

  try {
    await client.views.open({
      trigger_id: body.trigger_id,
      view: planEventModal(),
    });
  } catch (error) {
    logger.error(error);
  }
});

app.view("suggestCallback", async ({ body, ack, client }: any) => {
  await ack();

  const { nameInput, locationInput, websiteInput } = body.view.state.values;

  const name: string = nameInput.input.value;
  const location: string = locationInput.input.value;
  const website: string = websiteInput.input.value;

  const response = await api.post("/venues", { name, location, website });
  api.post("/events", { venueId: response.data._id });

  await client.chat.postMessage({
    channel: "eat-guild",
    text: `<@${body.user.id}> suggested to go to <${website}|${name}> in ${location}.`,
  });
});

app.options("eventSelect", async ({ ack, body, options, client }: any) => {
  const opts = {
    options: [
      {
        label: "[UXD-342] The button color should be artichoke green, not jalapeño",
        value: "UXD-342",
      },
      {
        label: "[FE-459] Remove the marquee tag",
        value: "FE-459",
      },
      {
        label: "[FE-238] Too many shades of gray in master CSS",
        value: "FE-238",
      },
    ],
  };

  console.log("Acking options... QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");

  await ack({ options: opts });
});

appRunner.setup(app);
