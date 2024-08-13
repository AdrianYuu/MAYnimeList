const db = require("../config/mysql.database");

const getUserByEmail = async (email) => {
  try {
    const [results] = await db
      .promise()
      .query("SELECT * FROM users WHERE email = ?", [email]);

    return results[0];
  } catch (error) {
    throw new Error(error.message);
  }
};

const getUserById = async (id) => {
  try {
    const [results] = await db
      .promise()
      .query("SELECT * FROM users WHERE id = ?", [id]);

    return results[0];
  } catch (error) {
    throw new Error(error.message);
  }
};

const createUser = async (data) => {
  try {
    const [result] = await db
      .promise()
      .query("INSERT INTO users (username, email, password) VALUES (?, ?, ?)", [
        data.username,
        data.email,
        data.password,
      ]);

    return result.affectedRows;
  } catch (error) {
    throw new Error(error.message);
  }
};

module.exports = {
  getUserByEmail,
  getUserById,
  createUser,
};
