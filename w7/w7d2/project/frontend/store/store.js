import { createStore, applyMiddleware } from 'redux';
import {thunkMiddleware} from '../middleware/thunk';
import RootReducer from '../reducers/root_reducer';

const configureStore = (preloadedState = {}) => {
  const store = createStore(RootReducer, preloadedState, applyMiddleware(thunkMiddleware));
  // store.subscribe(() => {
  //   localStorage.state = JSON.stringify(store.getState());
  // });
  window.store = store;
  return store;
};

export default configureStore;
