import {connect} from 'react-redux';
import StepList from './step_list';
import receiveStep from '../../actions/step_actions';

function mapStatesToProps(state) {
  return {
    steps: state.steps
  };
}

function mapDispatchToProps(dispatch) {
  return {
    receiveStep: (step) => dispatch(receiveStep(step))
  };
}
