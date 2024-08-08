const animeRepository = require("../repositories/anime.repository");

const getAnimes = async () => {
  const animes = await animeRepository.getAnimes();

  if (animes.length === 0) {
    throw new Error("There is no animes.");
  }

  return animes;
};

const getAnimeById = async (id) => {
  const anime = await animeRepository.getAnimeById(id);

  if (!anime) {
    throw new Error("There is no anime.");
  }

  return anime;
};

const createAnime = async (data) => {
  const affectedRows = await animeRepository.createAnime(data);

  if (affectedRows === 0) {
    throw new Error("Failed to create anime.");
  }

  return data;
};

const updateAnime = async (id, data) => {
  await getAnimeById(id);

  const affectedRows = await animeRepository.updateAnime(id, data);

  if (affectedRows === 0) {
    throw new Error("Failed to update anime.");
  }

  return data;
};

const deleteAnime = async (id) => {
  await getAnimeById(id);

  const affectedRows = await animeRepository.deleteAnime(id);

  if (affectedRows === 0) {
    throw new Error("Failed to delete anime.");
  }
};

module.exports = {
  getAnimes,
  getAnimeById,
  createAnime,
  updateAnime,
  deleteAnime,
};
