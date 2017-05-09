import React from 'react';
import TodoListItem from './todo_list_item';
import TodoListForm from './todo_form';

class TodoList extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <ul>
          {
            this.props.todos.map( (todo) => (
              <TodoListItem
                todo={todo}
                removeTodo={this.props.removeTodo}
                receiveTodo={this.props.receiveTodo}
                key={"todolistitem-"+todo.id}
              />
            ))
          }
        </ul>
        <TodoListForm receiveTodo={this.props.receiveTodo}/>
      </div>
    );
  }
}

export default TodoList;
