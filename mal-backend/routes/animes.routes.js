const express = require("express");
const router = express.Router();
const animeController = require("../controllers/anime.controller");

router.get("/", animeController.getAnimes);
router.get("/:id", animeController.getAnime);
router.post("/", animeController.createAnime);
router.put("/:id", animeController.updateAnime);
router.delete("/:id", animeController.deleteAnime);

module.exports = router;
