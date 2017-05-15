# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
user1 = User.create(username: 'guest', password: 'password')

Bench.destroy_all
bench1 = Bench.create(
  description: 'Zeitgeist Bench',
  lat: 37.770018,
  lng: -122.422219
)

bench2 = Bench.create(
  description: 'Clean Tenderloin Bench',
  lat: 37.784943, 
  lng: -122.415374
)

bench3 = Bench.create(
  description: 'Rich Bench',
  lat: 37.784765,
  lng: -122.402752
)