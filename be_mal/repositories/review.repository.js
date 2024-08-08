const db = require("../config/mysql.database");

const getReviewsByAnimeId = async (animeId) => {
  try {
    const [results] = await db.promise().query(
      "SELECT * FROM reviews WHERE anime_id = ?",
      [animeId]
    );

    return results;
  } catch (error) {
    throw new Error(error.message);
  }
};

module.exports = {
  getReviewsByAnimeId,
};
