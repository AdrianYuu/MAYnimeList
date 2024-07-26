var express = require("express");
var router = express.Router();
var multer = require("multer");
var { getAnimes, getAnime } = require("../controllers/anime.controller");

router.get("/get", (req, res, next) => {
  getAnimes().then(
    (result) => {
      res.status(200).json({
        message: "Successfully get animes",
        data: result,
      });
    },
    (error) => {
      res.status(500).json({
        message: "Failed to get animes",
        data: null,
      });
    }
  );
});

router.get("/get/:id", (req, res, next) => {
  getAnime().then(
    (result) => {
      res.status(200).json({
        message: "Successfully get anime",
        data: result,
      });
    },
    (error) => {
      res.status(500).json({ message: "Failed to get anime", data: null });
    }
  );
});

module.exports = router;
