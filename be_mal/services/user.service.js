const userRepository = require("../repositories/user.repository");
const bcrypt = require("bcrypt");

const login = async (data) => {
  const user = await userRepository.getUserByEmail(data.email);

  if (!user) {
    throw Error("There is no user with that email.");
  }

  if (!bcrypt.compareSync(data.password, user.password)) {
    throw Error("The password is wrong.");
  }

  return { id: user.id, username: user.username, email: user.email };
};

const getUserById = async (id) => {
  const user = await userRepository.getUserById(id);

  if (!user) {
    throw new Error("There is no user.");
  }

  return user;
};

const register = async (data) => {
  const isExists = await userRepository.getUserByEmail(data.email);

  if (isExists) {
    throw new Error("Email have been taken.");
  }

  data.password = bcrypt.hashSync(data.password, 10);

  const affectedRows = await userRepository.createUser(data);

  if (affectedRows === 0) {
    throw new Error("Failed to create user.");
  }

  return data;
};

module.exports = {
  login,
  register,
  getUserById,
};
