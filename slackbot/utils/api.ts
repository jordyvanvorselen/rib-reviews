import axios from "axios";

export const get = async (url: string) => {
  return axios.get(`${process.env.API_BASE_URL}${url}`, {
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
      Authorization: process.env.API_KEY,
    },
  });
};

export const post = async (url: string, body: object | undefined) => {
  return axios.post(
    `${process.env.API_BASE_URL}/api${url}`,
    JSON.stringify(body),
    {
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
        Authorization: process.env.API_KEY,
      },
    }
  );
};
