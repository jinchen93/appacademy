import { createStore, applyMiddleware } from 'redux';
import RootReducer from '../reducers/root_reducer';

const addLoggingToDispatch = store => (
  next => (
    action => {
      console.log(store.getState());
      console.log(action);
      store.dispatch(action);
      console.log(store.getState());
      return next(action);
    }
  )
);


const configureStore = (preloadedState = {}) => {
  const store = createStore(
    RootReducer,
    preloadedState,
    applyMiddleware(addLoggingToDispatch)
  );

  store.subscribe(() => {
    localStorage.state = JSON.stringify(store.getState());
  });
  return store;
}

export default configureStore;
