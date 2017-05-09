import React from 'react';

class TodoListForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title: "",
      body: ""
    };
  }

  onFormSubmit(e) {
    e.preventDefault();
    const newTodo = {
      id: this.uniqueId(),
      title: this.state.title,
      body: this.state.body,
      done: false
    };
    this.props.receiveTodo(newTodo);
    this.setState({
      title: "",
      body: ""
    });
  }

  uniqueId() {
    return new Date().getTime();
  }

  onInputChange(e) {
    const key = e.currentTarget.className;
    const newState = {};
    newState[key] = e.currentTarget.value;
    this.setState(newState);
  }

  render() {
    return (

      <form onSubmit={this.onFormSubmit.bind(this)}>
        <label>
          Title:
          <input
            onChange={this.onInputChange.bind(this)}
            type="text"
            placeholder="JIN"
            className="title"
          />
        </label>

        <label>
          Body:
          <input
            onChange={this.onInputChange.bind(this)}
            type="text"
            placeholder="IS THE BEST"
            className="body"
          />
        </label>

        <button type="submit">Add Todo</button>
      </form>

    );
  }
}

export default TodoListForm;
