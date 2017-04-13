# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.destroy_all
User.create(user_name: 'jinchen')
User.create(user_name: 'monte')
User.create(user_name: 'luke')

# Poll.destroy_all
Poll.create(title: 'Food', author_id: 1)
Poll.create(title: 'Languages', author_id: 2)
Poll.create(title: 'Beer', author_id: 3)

# Question.destroy_all
Question.create(question_text: 'Favorite food?', poll_id: 1)
Question.create(question_text: 'Favorite language?', poll_id: 2)
Question.create(question_text: 'Favorite beer?', poll_id: 3)

# AnswerChoice.destroy_all
AnswerChoice.create(answer_text: 'Hotdog', question_id: 1)
AnswerChoice.create(answer_text: 'Apple', question_id: 1)
AnswerChoice.create(answer_text: 'Tacos', question_id: 1)

AnswerChoice.create(answer_text: 'Ruby', question_id: 2)
AnswerChoice.create(answer_text: 'Python', question_id: 2)

AnswerChoice.create(answer_text: 'Bud', question_id: 3)
AnswerChoice.create(answer_text: 'Light', question_id: 3)

# Response.destroy_all
Response.create(user_id: 1, answer_choice_id: 4)
Response.create(user_id: 1, answer_choice_id: 7)
Response.create(user_id: 2, answer_choice_id: 2)
Response.create(user_id: 2, answer_choice_id: 6)
Response.create(user_id: 3, answer_choice_id: 1)
Response.create(user_id: 3, answer_choice_id: 4)
