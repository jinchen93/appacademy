import React from 'react';

function TodoDetailView(props){
  const handleDeleteClick = () => {
    props.removeTodo(props.todo);
  };

  return (
    <div>
      <p>{props.todo.body}</p>
      <button type="button" onClick={handleDeleteClick}>
        Delete
      </button>
    </div>
  );
}

export default TodoDetailView;
