const jwt = require("jsonwebtoken");

module.exports = function (req, res, next) {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1]; // Assuming format: "Bearer <token>"

  console.log("Token received:", token); // Log the token for debugging

  if (!token) {
    return res.status(401).json({ error: "Access denied. No token provided." });
  }

  try {
    const decoded = jwt.verify(token, "jwt_secret");
    req.user = decoded;
    next();
  } catch (error) {
    console.error("Token verification error:", error); // Log the error for debugging
    res.status(400).json({ error: "Invalid token." });
  }
};
