const db = require("../config/mysql.database");

const getAnimes = async () => {
  try {
    const [results] = await db.promise().query("SELECT * FROM animes");

    return results;
  } catch (error) {
    throw Error(`Error: ${error.message}`);
  }
};

const getAnime = async (id) => {
  try {
    const [results] = await db
      .promise()
      .query("SELECT * FROM animes WHERE id = ?", [id]);

    return results[0];
  } catch (error) {
    throw Error(`Error: ${error.message}`);
  }
};

const createAnime = async (data) => {
  try {
    const [result] = await db
      .promise()
      .query(
        "INSERT INTO animes (name, description, genre, rating, total_episode, image_url) VALUES (?, ?, ?, ?, ?, ?)",
        [
          data.name,
          data.description,
          data.genre,
          data.rating,
          data.total_episode,
          data.image_url,
        ]
      );
    return result.affectedRows;
  } catch (error) {
    throw Error(`Error: ${error.message}`);
  }
};

const updateAnime = async (id, data) => {
  try {
    const [result] = await db
      .promise()
      .query(
        "UPDATE animes SET name = ?, description = ?, genre = ?, rating = ?, total_episode = ?, image_url = ? WHERE id = ?",
        [
          data.name,
          data.description,
          data.genre,
          data.rating,
          data.total_episode,
          data.image_url,
          id,
        ]
      );

    return result.affectedRows;
  } catch (error) {
    throw Error(`Error: ${error.message}`);
  }
};

const deleteAnime = async (id) => {
  try {
    const [result] = await db
      .promise()
      .query("DELETE FROM animes WHERE id = ?", [id]);

    return result.affectedRows;
  } catch (error) {
    throw Error(`Error: ${error.message}`);
  }
};

module.exports = {
  getAnimes,
  getAnime,
  createAnime,
  updateAnime,
  deleteAnime,
};
