"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class Transactions extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.User, { foreignKey: "userId" });
      this.belongsTo(models.Categories, { foreignKey: "userId" });
    }
  }
  Transactions.init(
    {
      tId: DataTypes.STRING,
      title: DataTypes.STRING,
      type: DataTypes.STRING,
      description: DataTypes.STRING,
      category: DataTypes.STRING,
      amount: DataTypes.DOUBLE,
      date: DataTypes.DATE,
      userId: DataTypes.STRING,
    },
    {
      sequelize,
      modelName: "Transactions",
    }
  );
  return Transactions;
};
