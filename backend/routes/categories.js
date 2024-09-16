const express = require("express");
const router = express.Router();
const { User, Categories } = require("../models");

// Routes

// Create a new category
router.post("/", async (req, res) => {
  try {
    const category = await Categories.create(req.body);
    res.json(category);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to create category" });
  }
});

// Get all categories
router.get("/", async (req, res) => {
  try {
    const categories = await Categories.findAll();
    res.json(categories);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get categories" });
  }
});

// Get category by id
router.get("/:id", async (req, res) => {
  try {
    const category = await Categories.findByPk(req.params.id);
    res.json(category);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get category" });
  }
});

// Update category by id
router.put("/:id", async (req, res) => {
  try {
    const category = await Categories.findByPk(req.params.id);
    await category.update(req.body);
    var response = {
      message: "Category updated successfully",
      category: category,
    };
    res.json(response);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to update category" });
  }
});

// Delete category by id
router.delete("/:id", async (req, res) => {
  try {
    const category = await Categories.findByPk(req.params.id);
    await category.destroy();
    res.json({ message: "Category deleted successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to delete category" });
  }
});

// Get all categories with budget
router.get("/budget", async (req, res) => {
  try {
    const categories = await Categories.findAll({
      include: Budget,
    });
    res.json(categories);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get categories" });
  }
});

module.exports = router;
