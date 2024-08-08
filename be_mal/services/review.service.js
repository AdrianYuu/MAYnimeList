const reviewRepository = require("../repositories/review.repository");
const animeRepository = require("../repositories/anime.repository");

const getReviewsByAnimeId = async (animeId) => {
  const anime = await animeRepository.getAnimeById(animeId);

  if (!anime) {
    throw new Error("There is no anime.");
  }

  const reviews = await reviewRepository.getReviewsByAnimeId(animeId);

  if (reviews.length === 0) {
    throw new Error("There is no reviews.");
  }

  return reviews;
};

module.exports = {
  getReviewsByAnimeId,
};
