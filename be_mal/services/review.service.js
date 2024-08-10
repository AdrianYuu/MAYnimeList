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

const createReview = async (data) => {
  const affectedRows = await reviewRepository.createReview(data);

  if (affectedRows === 0) {
    throw new Error("Failed to create review.");
  }

  return data;
};

module.exports = {
  getReviewsByAnimeId,
  createReview,
};
