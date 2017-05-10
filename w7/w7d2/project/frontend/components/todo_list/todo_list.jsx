import React from 'react';
// Components
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {
  componentDidMount() {
    this.props.fetchTodos();
  }

  render() {
    const { todos, receiveTodo, createTodo, clearErrors } = this.props;
    const todoItems = todos.map(todo => (
        <TodoListItem
          key={`todo-list-item${todo.id}`}
          todo={todo}
          receiveTodo={ receiveTodo } />
      )
    );

    return(
      <div>
        <div className="errors">
          <ul>
            {this.props.errors.map( (err, idx) => <li key={idx}>{err}</li> )}
          </ul>
        </div>
        <ul className="todo-list">
          { todoItems }
        </ul>
        <TodoForm
          clearErrors={clearErrors}
          createTodo={createTodo}
          receiveTodo={ receiveTodo }
        />
      </div>
    );
  }
}

export default TodoList;
