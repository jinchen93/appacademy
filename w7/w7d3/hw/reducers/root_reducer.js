import { combineReducers } from 'redux';

import GiphysReducer from './giphys_reducer';

const rootReducer = combineReducers({
  giphys: GiphysReducer
});

export default rootReducer;
