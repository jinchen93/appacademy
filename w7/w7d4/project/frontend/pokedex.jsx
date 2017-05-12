import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
import { fetchPokemonDetails } from './util/api_util';
import { requestSinglePokemon, createPokemon } from './actions/pokemon_actions';
import { selectPokemonItem } from './reducers/selectors';

document.addEventListener('DOMContentLoaded', () => {
  const rootEl = document.getElementById("root");
  const store = configureStore();
  window.fetchPokemonDetails = fetchPokemonDetails;
  window.requestSinglePokemon = requestSinglePokemon;
  window.store = store;
  window.selectPokemonItem = selectPokemonItem;
  window.createPokemon = createPokemon;

  ReactDOM.render(<Root store={store}/>, rootEl);
});
