import { PrismaClient } from "@prisma/client";
import { AppRunner } from "@seratch_/bolt-http-runner";
import { PrismaInstallationStore } from "@seratch_/bolt-prisma";
import { App } from "@slack/bolt";
import { ConsoleLogger, LogLevel } from "@slack/logger";
import dateFormatter from "date-and-time";
import { Blocks, Divider, Elements, Image, Message, Modal, Section } from "slack-block-builder";

import * as api from "../../../utils/api";

require("dotenv").config();

const logger = new ConsoleLogger();
logger.setLevel(LogLevel.DEBUG);

type Venue = {
  _id: string;
  location: string;
  name: string;
  website: string;
};

type Event = {
  _id: string;
  date: string | null;
  venueId: string;
};

const prismaClient = new PrismaClient({ log: [{ emit: "stdout", level: "query" }] });
const installationStore = new PrismaInstallationStore({
  // The name `slackAppInstallation` can be different
  // if you use a different name in your Prisma schema
  prismaTable: prismaClient.slackAppInstallation,
  clientId: process.env.SLACK_CLIENT_ID,
  logger,
});

const databaseData: { [key: string]: any } = {};
const database = {
  set: async (key: string, data: any) => {
    databaseData[key] = data;
  },
  get: async (key: string) => {
    return databaseData[key];
  },
};

export const appRunner = new AppRunner({
  token: process.env.SLACK_BOT_TOKEN,
  signingSecret: process.env.SLACK_SIGNING_SECRET as string,
  clientId: process.env.SLACK_CLIENT_ID,
  clientSecret: process.env.SLACK_CLIENT_SECRET,
  stateSecret: process.env.SLACK_STATE_SECRET,
  processBeforeResponse: true,
  scopes: ["commands", "chat:write", "app_mentions:read"],
  installationStore,
  logger,
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
  return Modal({ title: "Plan the next event", callbackId: "planCallback" })
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

const eventPlannedMessage = (userId: string, venueName: string, date: string, time: string) => {
  return Message()
    .asUser()
    .blocks(
      Section({
        text: `<@${userId}> has scheduled a new eat guild event!  :poultry_leg: :partying_face: :broccoli:`,
      }),
      Divider(),
      Section({
        text: `:house_with_garden:  *${venueName}*\n:date:  ${date}\n:alarm_clock:  ${time}\n\n:link:  <https://eatguild.nl|Open in app>`,
      }).accessory(
        Image({
          imageUrl: "https://api.slack.com/img/blocks/bkb_template_images/notifications.png",
          altText: "calendar thumbnail",
        })
      ),
      Divider()
    )
    .buildToObject().blocks;
};

function convertTZ(date: string | Date, tzString: string) {
  return new Date(
    (typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {
      timeZone: tzString,
    })
  );
}

const toOption = (id: string, name: string) => {
  return {
    text: {
      type: "plain_text",
      text: name,
    },
    value: id,
  };
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

app.view("planCallback", async ({ body, ack, client }: any) => {
  await ack();

  const { eventInput, dateInput } = body.view.state.values;

  const id: string = eventInput.eventSelect.selected_option.value;
  const epoch: string = dateInput.input.selected_date_time;
  const venueName = eventInput.eventSelect.selected_option.text.text;

  const epochDate = new Date(0);
  epochDate.setSeconds(parseInt(epoch));
  const formattedDate = dateFormatter.format(
    convertTZ(epochDate, "Europe/Amsterdam"),
    "YYYY-MM-DD HH:mm:ss"
  );

  const response = await api.put(`/events/${id}`, { date: formattedDate });

  if (response.status !== 200) return;

  await client.chat.postMessage({
    channel: "eat-guild",
    blocks: eventPlannedMessage(
      body.user.id,
      venueName,
      dateFormatter.format(new Date(formattedDate), "ddd, MMM DD YYYY"),
      dateFormatter.format(new Date(formattedDate), "h:mm A")
    ),
  });
});

app.options("eventSelect", async ({ ack }: any) => {
  const venuesResponse = await api.get("/venues");
  const eventsResponse = await api.get("/events");

  const venues = venuesResponse.data as Venue[];
  const events = eventsResponse.data as Event[];

  const options = events
    .filter((event) => !event.date)
    .map((event) =>
      toOption(event._id, venues.find((venue) => venue._id === event.venueId)?.name || "")
    );

  await ack({ options });
});

appRunner.setup(app);
