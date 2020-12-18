# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all
Adoption.destroy_all

FactoryBot.create_list(:shelter, 5)

FactoryBot.create_list(:application, 5)

5.times do
  Shelter.all.each do |shelter|
    shelter.pets.create(name: Faker::Artist.unique.name, approximate_age: rand(1..9), sex: rand(0..1), description: Faker::TvShows::DrWho.quote)
  end
end