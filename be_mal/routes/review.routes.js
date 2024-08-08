const express = require("express");
const router = express.Router();
const reviewController = require("../controllers/review.controller");

router.get("/:animeId", reviewController.getReviewsByAnimeId);

module.exports = router;
