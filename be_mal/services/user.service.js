const userRepository = require("../repositories/user.repository");

const login = async (data) => {
  const user = await userRepository.getUserByEmail(data.email);

  if (!user) {
    throw Error("There is no user with that email.");
  }

  if (user.password !== data.password) {
    throw Error("The password is wrong.");
  }

  return { id: user.id, username: user.username, email: user.email };
};

module.exports = {
  login,
};
