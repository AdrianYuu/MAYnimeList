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
    }

    const user = await userService.login(data);

    res.status(200).json({ message: "Successfully login.", data: user });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = {
  login,
};
