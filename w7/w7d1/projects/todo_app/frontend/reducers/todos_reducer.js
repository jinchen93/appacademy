import {
  RECEIVE_TODOS,
  RECEIVE_TODO,
  REMOVE_TODO
} from '../actions/todo_actions.js';
import merge from 'lodash/merge';

const initState = {
  '1': {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  '2': {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  },
};

export const todosReducer = (state = initState, action) => {
  switch(action.type) {
    case RECEIVE_TODOS:
      const newTodosState = merge({}, state);
      action.todos.forEach( todo => {
        newTodosState[todo.id] = todo;
      });
      return newTodosState;

    case RECEIVE_TODO:
      const newTodo = {};
      const newTodoState = merge(newTodo, state);
      newTodoState[action.todo.id] = action.todo;
      return newTodoState;

    case REMOVE_TODO:
      const newRemoveState = merge({}, state);
      delete newRemoveState[action.todo.id];
      return newRemoveState;

    default:
      return state;
  }
};
