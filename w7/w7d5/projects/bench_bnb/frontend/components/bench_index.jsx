import React from "react";
import BenchIndexItem from "./bench_index_item";

class BenchIndex extends React.Component {
  componentDidMount() {
    this.props.fetchBenches();
  }

  render() {
    const { benches } = this.props;

    if (Object.keys(benches).length === 0) {
      return <div className="spinner" />;
    } else {
      return (
        <ul>
          {benches.map((bench, idx) => (
            <BenchIndexItem bench={bench} key={"bench" + idx} />
          ))}
        </ul>
      );
    }
  }
}

export default BenchIndex;
