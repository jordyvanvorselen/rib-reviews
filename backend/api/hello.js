module.exports = (req, res) => {
  if (req.method !== "GET") return;

  res.json({ Hello: "World!" });
};
