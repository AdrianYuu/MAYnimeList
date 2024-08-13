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

    if (data.review.trim() == "") {
      res.status(400).json({ message: "Review can't be empty." });
      return;
    }

    const review = await reviewService.createReview(data);

    res
      .status(200)
      .json({ message: "Successfully insert review.", data: review });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};
const updateReview = async (req, res, next) => {
  try {
    const id = req.params.id;
    const data = req.body;

    if (data.review.trim() == "") {
      res.status(400).json({ message: "Review can't be empty." });
      return;
    }

    const review = await reviewService.updateReview(id, data);

    res
      .status(200)
      .json({ message: "Successfully update review.", data: review });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const deleteReview = async (req, res, next) => {
  try {
    const id = req.params.id;
    await reviewService.deleteReview(id);

    res.status(200).json({ message: "Successfully delete review." });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = {
  getReviewsByAnimeId,
  createReview,
  updateReview,
  deleteReview,
};
