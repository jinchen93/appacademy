# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.destroy_all
# u1 = User.create(username: 'Jin')
# u2 = User.create(username: 'Al')
# u3 = User.create(username: 'Bob')
#
# a1 = Artwork.create(
#   title: 'A1 Sauce',
#   image_url: 'www.imgur/a1.jpg',
#   artist_id: u2.id
# )
#
# a2 = Artwork.create(
#   title: 'A Day in the Life of an App Academy Student',
#   image_url: 'www.imgur.com/aastudent.jpg',
#   artist_id: u1.id
# )
#
# a3 = Artwork.create(
#   title: 'Bobs Burgers',
#   image_url: 'www.bobsburger.com/tasty.jpg',
#   artist_id: u3.id
# )
#
# s1 = ArtworkShare.create(
#   viewer_id: u1.id,
#   artwork_id: a1.id
# )
#
# s2 = ArtworkShare.create(
#   viewer_id: u1.id,
#   artwork_id: a2.id
# )
#
# s3 = ArtworkShare.create(
#   viewer_id: u2.id,
#   artwork_id: a1.id
# )
#
# s4 = ArtworkShare.create(
#   viewer_id: u2.id,
#   artwork_id: a3.id
# )
#
# s5 = ArtworkShare.create(
#   viewer_id: u3.id,
#   artwork_id: a3.id
# )

c1 = Comment.create(
  author_id: 11,
  artwork_id: 1,
  body: 'Thats some goooood sauce'
)

c2 = Comment.create(
  author_id: 11,
  artwork_id: 3,
  body: 'Thats some gooooooood burgers'
)

c3 = Comment.create(
  author_id: 12,
  artwork_id: 3,
  body: 'Who is Bob?'
)

c4 = Comment.create(
  author_id: 13,
  artwork_id: 3,
  body: 'Yeah man, I grilled it myself'
)
