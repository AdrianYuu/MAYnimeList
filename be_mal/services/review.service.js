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

const getReviewById = async (id) => {
  const review = await reviewRepository.getReviewById(id);

  if (!review) {
    throw new Error("There is no review.");
  }

  return review;
};

const createReview = async (data) => {
  const affectedRows = await reviewRepository.createReview(data);

  if (affectedRows === 0) {
    throw new Error("Failed to create review.");
  }

  return data;
};

const updateReview = async (id, data) => {
  await getReviewById(id);

  const affectedRows = await reviewRepository.updateReview(id, data);

  if (affectedRows === 0) {
    throw new Error("Failed to update review.");
  }

  return data;
};

const deleteReview = async (id) => {
  await getReviewById(id);

  const affectedRows = await reviewRepository.deleteReview(id);

  if (affectedRows === 0) {
    throw new Error("Failed to delete review.");
  }
};

module.exports = {
  getReviewsByAnimeId,
  createReview,
  updateReview,
  deleteReview,
};
