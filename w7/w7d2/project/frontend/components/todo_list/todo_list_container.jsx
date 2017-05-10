import { connect } from 'react-redux';
import TodoList from './todo_list';

// Actions
import {
  receiveTodos,
  receiveTodo,
  fetchTodos,
  createTodo
} from '../../actions/todo_actions';
import { allTodos } from '../../reducers/selectors';
import { clearErrors } from '../../actions/error_actions';

const mapStateToProps = state => ({
  todos: allTodos(state),
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
  receiveTodos: () => dispatch(receiveTodos()),
  receiveTodo: todo => dispatch(receiveTodo(todo)),
  fetchTodos: () => dispatch(fetchTodos()),
  createTodo: todo => dispatch(createTodo(todo)),
  clearErrors: () => dispatch(clearErrors())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
