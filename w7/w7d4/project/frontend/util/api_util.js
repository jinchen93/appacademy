export const fetchAllPokemon = () =>
  $.ajax({
    method: "GET",
    url: "/api/pokemon"
  });

export const fetchPokemonDetails = id =>
  $.ajax({
    method: "GET",
    url: `/api/pokemon/${id}`
  });

export const createPokemon = pokemon => {
  console.log(pokemon);
  return $.ajax({
    method: "POST",
    url: `/api/pokemon`,
    data: { pokemon }
  });
};
