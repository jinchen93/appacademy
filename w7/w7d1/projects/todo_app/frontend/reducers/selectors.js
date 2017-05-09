export const allTodos = (state) => {
  const todos = Object.keys(state.todos);
  return todos.map( key => state.todos[key]);
};
