# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

5.times do
  User.create(email: Faker::Internet.email, premium: true)
end

ShortenedUrl.destroy_all

rand(10..20).times do
  ShortenedUrl.shortenify(
    User.order('RANDOM()').first,
    Faker::Internet.url
  )
end

rand(10..20).times do
  Visit.record_visit!(
    User.order('RANDOM()').first,
    ShortenedUrl.order('RANDOM()').first
  )
end
