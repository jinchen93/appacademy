# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Todo.destroy_all
Step.destroy_all

todo1 = Todo.create({
  title: 'Dark Souls',
  body: 'Try not to rage quit',
  done: false
})

todo2 = Todo.create({
  title: "Ahmed's bucket list",
  body: 'Make the best Twitch clone',
  done: true
})

todo3 = Todo.create({
  title: "Frontend",
  body: 'Come up with frontend ideas',
  done: false
})

steps1a = Step.create({
  title: "walk to store",
  done: false,
  todo_id: todo1.id
})
steps1b = Step.create({
  title: "buy soap",
  done: false,
  todo_id: todo1.id
})
steps2a = Step.create({
  title: "walk to park",
  done: false,
  todo_id: todo2.id
})
steps3a = Step.create({
  title: "play with dog",
  done: false,
  todo_id: todo3.id
});
