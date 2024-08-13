const userService = require("../services/user.service");

const login = async (req, res, next) => {
  try {
    const data = req.body;

    if (data.email.trim() == "" || data.password.trim() == "") {
      res.status(400).json({ message: "All fields is required." });
      return;
    } else if (!data.email.trim().endsWith(".com")) {
      res.status(400).json({ message: "Email must ends with '.com'." });
      return;
    } else if (!data.email.includes("@")) {
      res.status(400).json({ message: "Email must contains '@'." });
      return;
    }

    const user = await userService.login(data);

    res.status(200).json({ message: "Successfully login.", data: user });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const getUserById = async (req, res, next) => {
  try {
    const id = req.params.id;
    const user = await userService.getUserById(id);

    res.status(200).json({ message: "Successfully get user.", data: user });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const register = async (req, res, next) => {
  try {
    const data = req.body;

    if (
      data.username.trim() == "" ||
      data.email.trim() == "" ||
      data.password.trim() == ""
    ) {
      res.status(400).json({ message: "All fields is required." });
      return;
    } else if (!data.email.trim().endsWith(".com")) {
      res.status(400).json({ message: "Email must ends with '.com'." });
      return;
    }

    const user = await userService.register(data);

    res.status(200).json({ message: "Sucessfully register user.", data: user });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = {
  login,
  register,
  getUserById,
};
