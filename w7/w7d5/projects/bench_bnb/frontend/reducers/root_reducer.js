import { combineReducers } from "redux";
import SessionReducer from "./session_reducer";
import benchesReducer from "./benches_reducer";

const RootReducer = combineReducers({
  session: SessionReducer,
  benches: benchesReducer,
});

export default RootReducer;
