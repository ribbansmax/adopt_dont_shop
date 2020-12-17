require 'rails_helper'

RSpec.describe 'Admin Shelters show page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
  end
  
  it "Displays the address and name" do
    visit "/admin/shelters/#{@shelter1.id}"
    expect(page).to have_content("#{@shelter1.name}")
    expect(page).to have_content("#{@shelter1.full_address}")
  end

  it "Displays the statistics correctly" do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")

    @pet1.update(adoptable: false)

    visit "/admin/shelters/#{@shelter1.id}"

    expect(page).to have_content("Average Age: #{@shelter1.average_pet_age}")
    expect(page).to have_content("Adoptable Pets: #{@shelter1.adoptable_pets}") 
    expect(page).to have_content("Adopted Pets: #{@shelter1.adopted_pets}")
  end
end