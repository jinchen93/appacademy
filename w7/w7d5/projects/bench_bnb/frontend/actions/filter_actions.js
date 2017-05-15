import { fetchBenches } from "./bench_actions";

export const CHANGE_FILTER = "CHANGE_FILTER";

export const changeFilter = (filter, value) => ({
  type: CHANGE_FILTER,
  filter,
  value,
});

export const updateFilter = (filter, value) => {
  return (dispatch, getState) => {
    dispatch(changeFilter(filter, value));
    return fetchBenches(getState().filters)(dispatch);
  };
};
