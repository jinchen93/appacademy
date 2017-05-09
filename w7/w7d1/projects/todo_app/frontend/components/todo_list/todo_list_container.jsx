import {connect} from 'react-redux';
import TodoList from './todo_list';
import {allTodos} from '../../reducers/selectors';
import {receiveTodo, removeTodo} from '../../actions/todo_actions';
import {bindActionCreators} from 'redux';

const mapStateToProps = state => ({
  todos: allTodos(state)
});

// const mapDispatchToProps = dispatch => ({
//   receiveTodo: (todo) => dispatch(receiveTodo(todo)),
//   removeTodo: (todo) => dispatch(removeTodo(todo))
// });

// const mapDispatchToProps = dispatch => {
//   return bindActionCreators({
//     receiveTodo,
//     removeTodo
//   }, dispatch);
// };

// export default connect(mapStateToProps, mapDispatchToProps)(TodoList);
// FASTER
export default connect(mapStateToProps, {receiveTodo, removeTodo})(TodoList);
