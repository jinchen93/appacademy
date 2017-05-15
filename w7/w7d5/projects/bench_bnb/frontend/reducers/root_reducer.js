import { combineReducers } from "redux";
import SessionReducer from "./session_reducer";
import benchesReducer from "./benches_reducer";
import filterReducer from "./filter_reducer";

const RootReducer = combineReducers({
  session: SessionReducer,
  benches: benchesReducer,
  filters: filterReducer,
});

export default RootReducer;
