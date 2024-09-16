const express = require("express");
const router = express.Router();
const auth = require("../middleware/auth");
const { User, Transactions } = require("../models");

// Routes

// Add a new Transaction
router.post("/", auth, async (req, res) => {
  try {
    const transaction = await Transactions.create({
      ...req.body,
      userId: req.user.id,
    });
    res.status(201).json(transaction);
  } catch (error) {
    console.error(error);
    res.status(400).json({ error: error.message });
  }
});

// Get all transactions
router.get("/", auth, async (req, res) => {
  try {
    const transactions = await Transactions.findAll();
    res.status(200).json(transactions);
  } catch (error) {
    console.error(error);
    res.status(400).json({ error: error.message });
  }
});

// Get transaction by id
router.get("/:id", async (req, res) => {
  try {
    const transaction = await Transactions.findByPk(req.params.id);
    res.json(transaction);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get transaction" });
  }
});

// Update transaction by id
router.put("/:id", async (req, res) => {
  try {
    const transaction = await Transactions.findByPk(req.params.id);
    await transaction.update(req.body);
    var response = {
      message: "Transaction updated successfully",
      transaction: transaction,
    };
    res.json(response);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to update transaction" });
  }
});

// Delete transaction by id
router.delete("/:id", async (req, res) => {
  try {
    const transaction = await Transactions.findByPk(req.params.id);
    await transaction.destroy();
    var response = {
      message: "Transaction deleted successfully",
      transaction: transaction,
    };
    res.json(response);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to delete transaction" });
  }
});

module.exports = router;
