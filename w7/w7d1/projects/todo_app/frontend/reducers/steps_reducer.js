import {
  RECEIVE_STEPS,
  RECEIVE_STEP,
  REMOVE_STEP
} from '../actions/step_actions.js';
import merge from 'lodash/merge';

const initState =  {
  1: { // this is the step with id = 1
    id: 1,
    title: "walk to store",
    done: false,
    todo_id: 1
  },
  2: { // this is the step with id = 2
    id: 2,
    title: "buy soap",
    done: false,
    todo_id: 1
  }
};

export const stepsReducer = (state = initState, action) => {
  switch(action.type) {
    case RECEIVE_STEPS:
      const newStepsState = merge({}, state);
      action.steps.forEach( step => {
        newStepsState[step.id] = step;
      });
      return newStepsState;

    case RECEIVE_STEP:
      const newStep = {};
      const newStepState = merge(newStep, state);
      newStepState[action.step.id] = action.step;
      return newStepState;

    case REMOVE_STEP:
      const newRemoveState = merge({}, state);
      delete newRemoveState[action.step.id];
      return newRemoveState;

    default:
      return state;
  }
};
