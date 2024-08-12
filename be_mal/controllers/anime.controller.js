const animeService = require("../services/anime.service");

const getAnimes = async (req, res, next) => {
  try {
    const animes = await animeService.getAnimes();

    res.status(200).json({ message: "Successfully get animes.", data: animes });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const getAnimeById = async (req, res, next) => {
  try {
    const id = req.params.id;
    const anime = await animeService.getAnimeById(id);

    res.status(200).json({ message: "Successfully get anime.", data: anime });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const createAnime = async (req, res, next) => {
  try {
    const data = req.body;

    if (req.file) {
      data.image_url = req.file.path.replace("public/", "/");
    }

    const anime = await animeService.createAnime(data);

    res.status(200).json({ message: "Sucessfully insert anime.", data: anime });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const updateAnime = async (req, res, next) => {
  try {
    const id = req.params.id;
    const data = req.body;

    if (req.file) {
      data.image_url = req.file.path.replace("public/", "");
    }

    const anime = await animeService.updateAnime(id, data);

    res
      .status(200)
      .json({ message: "Successfully update anime.", data: anime });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const deleteAnime = async (req, res, next) => {
  try {
    const id = req.params.id;
    await animeService.deleteAnime(id);

    res.status(200).json({ message: "Successfully delete anime." });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = {
  getAnimes,
  getAnimeById,
  createAnime,
  updateAnime,
  deleteAnime,
};
