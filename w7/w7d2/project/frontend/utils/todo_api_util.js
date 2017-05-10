export const fetchTodos = () => (
  $.ajax({
    method: 'GET',
    url: '/api/todos'
  })
);

export const createTodo = (todo) => {
  return $.ajax({
    method: 'POST',
    url: '/api/todos',
    data: {
      todo: todo
    },
    dataType: 'json'
  });
};

export const deleteTodo = todo => {
  return $.ajax({
    method: 'DELETE',
    url: '/api/todos/' + todo.id,
    dataType: 'json'
  });
};
