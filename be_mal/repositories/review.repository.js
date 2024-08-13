const db = require("../config/mysql.database");

const getReviewsByAnimeId = async (animeId) => {
  try {
    const [results] = await db
      .promise()
      .query("SELECT * FROM reviews WHERE anime_id = ?", [animeId]);

    return results;
  } catch (error) {
    throw new Error(error.message);
  }
};

const getReviewById = async (id) => {
  try {
    const [results] = await db
      .promise()
      .query("SELECT * FROM reviews WHERE id = ?", [id]);

    return results[0];
  } catch (error) {
    throw new Error(error.message);
  }
};

const createReview = async (data) => {
  try {
    const [result] = await db
      .promise()
      .query(
        "INSERT INTO reviews (user_id, anime_id, review) VALUES (?, ?, ?)",
        [data.user_id, data.anime_id, data.review]
      );

    return result.affectedRows;
  } catch (error) {
    throw new Error(error.message);
  }
};

const updateReview = async (id, data) => {
  try {
    const [result] = await db
      .promise()
      .query("UPDATE reviews SET review = ? WHERE id = ?", [data.review, id]);

    return result.affectedRows;
  } catch (error) {
    throw new Error(error.message);
  }
};

const deleteReview = async (id) => {
  try {
    const [result] = await db
      .promise()
      .query("DELETE FROM reviews WHERE id = ?", [id]);

    return result.affectedRows;
  } catch (error) {
    throw new Error(error.message);
  }
};

module.exports = {
  getReviewsByAnimeId,
  getReviewById,
  createReview,
  updateReview,
  deleteReview,
};
