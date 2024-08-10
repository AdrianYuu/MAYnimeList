const express = require("express");
const router = express.Router();
const animeController = require("../controllers/anime.controller");
const upload = require("../config/multer.config");

router.get("/", animeController.getAnimes);
router.get("/:id", animeController.getAnimeById);
router.post("/", upload.single("image"), animeController.createAnime);
router.put("/:id", upload.single("image"), animeController.updateAnime);
router.delete("/:id", animeController.deleteAnime);

module.exports = router;
