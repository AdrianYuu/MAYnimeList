const db = require("../config/mysql.database");

const findAnimes = async () => {
  return new Promise((resolve, reject) => {
    db.query("SELECT * FROM animes", (error, result) => {
      if (error) reject(error);
      resolve(result);
    });
  });
};

const findAnime = async (id) => {
  return new Promise((resolve, reject) => {
    db.query("SELECT * FROM animes WHERE id = ?", [id], (error, result) => {
      if (error) reject(error);
      resolve(result);
    });
  });
};

const insertAnime = async (data) => {
  return new Promise((resolve, reject) => {
    db.query(
      "INSERT INTO animes (name, description, genre, rating, total_episode, image_url) VALUES (?, ?, ?, ?, ?, ?)",
      [
        data.name,
        data.description,
        data.genre,
        data.rating,
        data.total_episode,
        data.image_url,
      ],
      (error, result) => {
        if (error) reject(error);
        resolve(result.affectedRows);
      }
    );
  });
};

const updateAnime = async (id, data) => {
  return new Promise((resolve, reject) => {
    db.query(
      "UPDATE animes SET name = ?, description = ?, genre = ?, rating = ?, total_episode = ?, image_url = ? WHERE id = ?",
      [
        data.name,
        data.description,
        data.genre,
        data.rating,
        data.total_episode,
        data.image_url,
        id,
      ],
      (error, result) => {
        if (error) reject(error);
        resolve(result.affectedRows);
      }
    );
  });
};

const deleteAnime = async (id) => {
  console.log(id);

  return new Promise((resolve, reject) => {
    db.query("DELETE FROM animes WHERE id = ?", [id], (error, result) => {
      if (error) reject(error);
      resolve(result.affectedRows);
    });
  });
};

module.exports = {
  findAnimes,
  findAnime,
  insertAnime,
  updateAnime,
  deleteAnime,
};
