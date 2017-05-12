import { createStore, applyMiddleware, compose } from 'redux';
import rootReducer from '../reducers/root_reducer';
import thunkMiddleware from '../middleware/thunk';

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

const configureStore = () => createStore(
  rootReducer,
  composeEnhancers(applyMiddleware(thunkMiddleware))
);

export default configureStore;
