const reviewService = require("../services/review.service");

const getReviewsByAnimeId = async (req, res, next) => {
  try {
    const animeId = req.params.animeId;
    const reviews = await reviewService.getReviewsByAnimeId(animeId);

    res
      .status(200)
      .json({ message: "Successfully get reviews.", data: reviews });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const createReview = async (req, res, next) => {
  try {
    const data = req.body;
    const review = await reviewService.createReview(data);

    res
      .status(200)
      .json({ message: "Successfully insert review", data: review });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = {
  getReviewsByAnimeId,
  createReview,
};
