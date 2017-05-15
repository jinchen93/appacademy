import { connect } from "react-redux";
import Search from "./search";
import { fetchBenches } from "../actions/bench_actions";
import { selectBenches } from "../reducers/selectors";
import { updateFilter } from "../actions/filter_actions";

const mapStateToProps = state => ({
  benches: selectBenches(state),
});

const mapDispatchToProps = dispatch => ({
  fetchBenches: filters => dispatch(fetchBenches(filters)),
  updateFilter: (filter, value) =>
    dispatch(updateFilter(filter, value)),
});

export default connect(mapStateToProps, mapDispatchToProps)(Search);
