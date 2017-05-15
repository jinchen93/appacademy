import { CHANGE_FILTER } from "../actions/filter_actions";
import merge from "lodash/merge";

const _initialState = {
  bounds: {},
};

const filterReducer = (state = _initialState, action) => {
  Object.freeze(state);

  switch (action.type) {
    case CHANGE_FILTER:
      return merge({}, state, { [action.filter]: action.value });
    default:
      return state;
  }
};

export default filterReducer;
