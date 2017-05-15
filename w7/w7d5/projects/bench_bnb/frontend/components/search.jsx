import React from "react";
import BenchMap from "./bench_map";
import BenchIndex from "./bench_index";

const Search = props => (
  <div>
    <BenchMap
      updateFilter={props.updateFilter}
      benches={props.benches}
    />
    <BenchIndex {...props} />
  </div>
);

export default Search;
