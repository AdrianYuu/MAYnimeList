const userService = require("../services/user.service");

const login = async (req, res, next) => {
  try {
    const data = req.body;
    const user = await userService.login(data);

    res.status(200).json({ message: "Successfully login.", data: user });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = {
  login,
};
