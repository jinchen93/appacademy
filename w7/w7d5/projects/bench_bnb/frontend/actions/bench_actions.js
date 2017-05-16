export const RECEIVE_BENCHES = "RECEIVE_BENCHES";
export const RECEIVE_BENCH = "RECEIVE_BENCH";
import * as BenchAPIUtil from "../util/bench_api_util";

export const receiveBenches = benches => ({
  type: RECEIVE_BENCHES,
  benches,
});

export const receiveBench = bench => ({
  type: RECEIVE_BENCH,
  bench,
});

export const fetchBenches = filters => {
  return dispatch =>
    BenchAPIUtil.fetchBenches(filters).then(benches =>
      dispatch(receiveBenches(benches))
    );
};

export const createBench = bench => {
  return dispatch =>
    BenchAPIUtil.createBench(bench).then(newBench =>
      dispatch(receiveBench(newBench))
    );
};
