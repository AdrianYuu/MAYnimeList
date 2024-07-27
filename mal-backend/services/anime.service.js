const { isEmptyArray } = require("../lib/util");
const {
  findAnimes,
  findAnime,
  insertAnime,
  updateAnime,
  deleteAnime,
} = require("../repositories/anime.repository");

const getAnimes = async () => {
  const animes = await findAnimes();

  if (isEmptyArray(animes)) {
    throw Error("There is no anime.");
  }

  return animes;
};

const getAnime = async (id) => {
  const anime = await findAnime(id);

  if (isEmptyArray(anime)) {
    throw Error("There is no anime.");
  }

  return anime;
};

const createAnime = async (data) => {
  const affectedRows = await insertAnime(data);

  if (affectedRows === 0) {
    throw Error("Failed to create anime.");
  }

  return data;
};

const editAnime = async (id, data) => {
  await getAnime(id);

  const affectedRows = await updateAnime(id, data);

  if (affectedRows === 0) {
    throw Error("Failed to update anime.");
  }

  return data;
};

const destroyAnime = async (id) => {
  await getAnime(id);

  const affectedRows = await deleteAnime(id);

  if (affectedRows === 0) {
    throw Error("Failed to delete anime.");
  }
};

module.exports = { getAnimes, getAnime, createAnime, editAnime, destroyAnime };
