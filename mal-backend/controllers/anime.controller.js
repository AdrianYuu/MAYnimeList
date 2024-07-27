const {
  getAnimes,
  getAnime,
  createAnime,
  editAnime,
  destroyAnime,
} = require("../services/anime.service");

const get = async (req, res, next) => {
  try {
    const animes = await getAnimes();

    res.status(200).json({ message: "Successfully get animes.", data: animes });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const getById = async (req, res, next) => {
  try {
    const id = req.params.id;
    const anime = await getAnime(id);

    res.status(200).json({ message: "Successfully get anime.", data: anime });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const post = async (req, res, next) => {
  try {
    const data = req.body;
    const anime = await createAnime(data);

    res.status(200).json({ message: "Sucessfully insert anime.", data: anime });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const put = async (req, res, next) => {
  try {
    const id = req.params.id;
    const data = req.body;
    const anime = await editAnime(id, data);

    res
      .status(200)
      .json({ message: "Successfully update anime.", data: anime });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const del = async (req, res, next) => {
  try {
    const id = req.params.id;
    await destroyAnime(id);

    res.status(200).json({ message: "Successfully delete anime." });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = { get, getById, post, put, del };
