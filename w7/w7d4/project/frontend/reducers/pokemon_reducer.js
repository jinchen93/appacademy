import { RECEIVE_ALL_POKEMON, ADD_POKE } from '../actions/pokemon_actions';

const pokemonReducer = (state = {}, action) => {
  Object.freeze(state);

  switch(action.type) {
    case RECEIVE_ALL_POKEMON:
      return action.pokemon;
    case ADD_POKE:
      return Object.assign({}, state, {
        [action.poke.id]: {
          id: action.poke.id,
          name: action.poke.name,
          image_url: action.poke.image_url
        }
      });
    default:
      return state;
  }
};

export default pokemonReducer;
