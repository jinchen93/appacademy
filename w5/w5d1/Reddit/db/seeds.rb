# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Sub.destroy_all
Post.destroy_all
PostSub.destroy_all

user1 = User.create(username: 'guest', password: 'password')

10.times do
  Sub.create(
    title: Faker::Hacker.verb + Faker::Hacker.noun,
    description: Faker::Hacker.say_something_smart,
    user_id: user1.id
  )
end


rand(5..10).times do
  n = rand(1..2)
  n == 2 ? fake_url = Faker::Internet.domain_name : fake_url = ""

  post = Post.new(
    title: "#{Faker::Hacker.adjective} #{Faker::Hacker.verb} #{Faker::Hacker.noun}",
    url: fake_url,
    content: Faker::Hacker.say_something_smart,
    user_id: user1.id
  )

  start_pos = rand(0..4)
  end_pos = rand(5..9)

  post.sub_ids = Sub.ids[start_pos..end_pos]

  post.save
end
