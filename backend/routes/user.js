const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const express = require("express");
const router = express.Router();
const { User } = require("../models");
const { UUIDV4 } = require("sequelize");

const saltRounds = 10;

// Register a new user
router.post("/register", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    // Checking if user already exists
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ error: "User already exists" });
    }

    // Hashing the password
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    // Creating a new user
    const user = await User.create({
      name,
      email,
      password: hashedPassword,
    });

    res.status(201).json({ message: "User created successfully", user });
  } catch (error) {
    console.error(error);
    res.status(400).json({ error: error.message });
  }
});

// User login
router.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find user by email
    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(400).json({ error: "User not found" });
    }

    // Compare password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ error: "Invlaid credentials" });
    }

    // Generate JWT
    const token = jwt.sign({ id: user.uId, email: user.email }, "jwt_secret", {
      expiresIn: "1h",
    });

    res.status(200).json({ message: "Login successful!", token });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all users
router.get("/", async (req, res) => {
  try {
    const users = await User.findAll();
    res.json(users);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get users" });
  }
});

// Get user by id
router.get("/:id", async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id);
    res.json(user);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get user" });
  }
});

// Update user by id
router.put("/:id", async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id);
    await user.update(req.body);
    var response = {
      message: "User updated successfully",
      user: user,
    };
    res.json(response);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to update user" });
  }
});

// Delete user by id
router.delete("/:id", async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id);
    await user.destroy();
    var response = {
      message: "User deleted successfully",
      user: user,
    };
    res.json(response);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to delete user" });
  }
});

// Get all transactions by user id
router.get("/:id/transactions", async (req, res) => {
  try {
    const transactions = await Transactions.findAll({
      where: { userId: req.params.id },
    });
    res.json(transactions);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get transactions" });
  }
});

// Get all categories of a user
router.get("/:id/category", async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id, {
      include: Categories,
    });
    res.json(user.Categories);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get categories" });
  }
});

module.exports = router;
