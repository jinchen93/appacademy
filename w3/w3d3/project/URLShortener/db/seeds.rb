# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
user1 = User.create(email: 'fake@gmail.com')
user2 = User.create(email: 'grandma@aol.com')
user3 = User.create(email: 'hottie@hotmail.com')
user4 = User.create(email: 'woohoo@yahoo.com')
user5 = User.create(email: 'myself@me.com')

ShortenedUrl.destroy_all
shortened_url1 = ShortenedUrl.create(
  long_url: "www.google.com",
  short_url: "goog.gl",
  submitter_id: user1.id
)
