const express = require("express");
const cors = require("cors");
const { sequelize } = require("./models/index.js");

const app = express();

var corsOptions = {
  origin: "http://localhost:3001",
};

// Middlewares
app.use(cors(corsOptions));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routing
const userRouter = require("./routes/user.js");
const transactionRouter = require("./routes/transactions.js");
const categoryRouter = require("./routes/categories.js");
const budgetRouter = require("./routes/budget.js");

app.use("/api/users", userRouter);
app.use("/api/transactions", transactionRouter);
app.use("/api/categories", categoryRouter);
app.use("/api/budget", budgetRouter);

// Testing API
app.get("/", (req, res) => {
  res.send("Hello form API!");
});

// Port
const PORT = process.env.PORT || 3000;

app.listen(3000, async () => {
  await sequelize.authenticate();
  console.log(`Database connected at port http://localhost:${PORT}`);
});
