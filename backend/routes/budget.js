const express = require("express");
const router = express.Router();
const { Categories, Budget } = require("../models");

// Routes

// Create a new budget
router.post("/", async (req, res) => {
  try {
    const budget = await Budget.create(req.body);
    res.status(201).json(budget);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all budgets
router.get("/", async (req, res) => {
  try {
    const budgets = await Budget.findAll({});
    res.status(200).json(budgets);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get a budget by id
router.get("/:id", async (req, res) => {
  try {
    const budget = await Budget.findByPk(req.params.id, {});
    res.status(200).json(budget);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Update a budget by id
router.put("/:id", async (req, res) => {
  try {
    const [updated] = await Budget.update(req.body, {
      where: { id: req.params.id },
    });
    if (updated) {
      const updatedBudget = await Budget.findByPk(req.params.id, {});
      return res.status(200).json({ budget: updatedBudget });
    }
    throw new Error("Budget not found");
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

// Delete a budget by id
router.delete("/:id", async (req, res) => {
  try {
    const deleted = await Budget.destroy({
      where: { id: req.params.id },
    });
    if (deleted) {
      return res.status(204).send("Budget deleted");
    }
    throw new Error("Budget not found");
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

module.exports = router;
