import { createStore, applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';
import thunkMiddleware from '../middleware/thunk';

const configureStore = () => createStore(
  rootReducer,
  applyMiddleware(thunkMiddleware)
);

export default configureStore;
