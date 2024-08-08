const animeRepository = require("../repositories/anime.repository");

const getAnimes = async () => {
  const animes = await animeRepository.getAnimes();

  if (animes.length === 0) {
    throw Error("There is no anime");
  }

  return animes;
};

const getAnime = async (id) => {
  const anime = await animeRepository.getAnime(id);

  if (!anime) {
    throw Error("There is no anime.");
  }

  return anime;
};

const createAnime = async (data) => {
  const affectedRows = await animeRepository.createAnime(data);

  if (affectedRows === 0) {
    throw Error("Failed to create anime.");
  }

  return data;
};

const updateAnime = async (id, data) => {
  await getAnime(id);

  const affectedRows = await animeRepository.updateAnime(id, data);

  if (affectedRows === 0) {
    throw Error("Failed to update anime.");
  }

  return data;
};

const deleteAnime = async (id) => {
  await getAnime(id);

  const affectedRows = await animeRepository.deleteAnime(id);

  if (affectedRows === 0) {
    throw Error("Failed to delete anime.");
  }
};

module.exports = { getAnimes, getAnime, createAnime, updateAnime, deleteAnime };