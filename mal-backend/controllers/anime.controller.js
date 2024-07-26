var db = require("../config/mysql.database");
var { isArrayEmpty } = require("../utils/array.util");

var getAnimes = () => {
  return new Promise((resolve, reject) => {
    db.query("SELECT * FROM animes", (error, result) => {
      if (!!error) reject(error);
      if (isArrayEmpty(result)) reject(error);
      resolve(result);
    });
  });
};

var getAnime = (id) => {
  return new Promise((resolve, reject) => {
    db.query("SELECT * FROM animes WHERE id = ?", [id], (error, result) => {
      if (!!error) reject(error);
      if (isArrayEmpty(result)) reject(error);
      resolve(result);
    });
  });
};

var createAnime = (
  name,
  description,
  genre,
  rating,
  total_episode,
  image_url
) => {
  return new Promise((resolve, reject) => {
    db.query(
      "INSERT INTO animes (name, description, genre, rating, total_episode, image_url) VALUES (?, ?, ?, ?, ?, ?)",
      [name, description, genre, rating, total_episode, image_url],
      (error, result) => {
        if (!!error) reject(error);
        resolve(result);
      }
    );
  });
};

var updateAnime = (
  id,
  name,
  description,
  genre,
  rating,
  total_episode,
  image_url
) => {
  return new Promise((resolve, reject) => {
    db.query(
      "UPDATE animes SET name = ?, description = ?, genre = ?, rating = ?, total_episode = ?, image_url = ? WHERE id = ?",
      [name, description, genre, rating, total_episode, image_url, id],
      (error, result) => {
        if (!!error) reject(error);
        resolve(result);
      }
    );
  });
};

var deleteAnime = (id) => {
  return new Promise((resolve, reject) => {
    db.query("DELETE FROM animes WHERE id = ?", [id], (error, result) => {
      if (!!error) reject(error);
      resolve(result);
    });
  });
};

module.exports = { getAnimes, getAnime, createAnime, updateAnime, deleteAnime };
