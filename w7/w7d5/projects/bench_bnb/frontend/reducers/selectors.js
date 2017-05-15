import values from "lodash/values";

export const selectBenches = state => values(state.benches);
