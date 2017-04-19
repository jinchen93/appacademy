# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all
cat1 = Cat.create(name: "George", color:"black", sex: "M", birth_date: "2015/01/20", description: "George is a good cat.")
cat2 = Cat.create(name: "Tom", color:"white", sex: "M", birth_date: "2016/01/20", description: "Tom is a lazy cat.")
cat3 = Cat.create(name: "Linda", color:"yellow", sex: "F", birth_date: "2013/01/20", description: "Linda is a old cat.")

CatRentalRequest.destroy_all
rent1 = CatRentalRequest.create(
  cat_id: cat1.id,
  start_date: "2016/04/15",
  end_date: "2016/04/18",
  status: "APPROVED"
)
rent2 = CatRentalRequest.create(
  cat_id: cat2.id,
  start_date: "2016/08/20",
  end_date: "2016/09/20",
  status: "APPROVED"
)
rent3 = CatRentalRequest.create(
  cat_id: cat3.id,
  start_date: "2017/09/20",
  end_date: "2017/09/22",
  status: "DENIED"
)

rent4 = CatRentalRequest.create(
  cat_id: cat1.id,
  start_date: "2016/11/20",
  end_date: "2016/11/25",
  status: "PENDING"
)
