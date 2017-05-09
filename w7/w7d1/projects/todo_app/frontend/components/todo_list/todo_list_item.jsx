import React from 'react';
import merge from 'lodash/merge';
import TodoDetailViewContainer from './todo_detail_view_container';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      detail: false
    };
  }

  handleDoneClick() {
    const todo = merge({}, this.props.todo);
    todo.done = !(this.props.todo.done);
    this.props.receiveTodo(todo);
  }

  renderTodoDetailView() {
    if(this.state.detail)
      return <TodoDetailViewContainer todo={this.props.todo} />;
    return "";
  }

  toggleDetailView() {
    this.setState({
      detail: !this.state.detail
    });
  }

  render() {
    const {title, body, done} = this.props.todo;
    return (
      <div className="todoListItem" onClick={this.toggleDetailView.bind(this)}>
        <h3>{title}</h3>
        {this.renderTodoDetailView()}

        <button type="button" onClick={this.handleDoneClick.bind(this)}>
          {done ? "undo" : "done"}
        </button>
      </div>
    );
  }
}

export default TodoListItem;
