require 'rails_helper'

RSpec.describe 'Admin Shelters show page' do
  # before :each do
  # end
  
  it "Displays the address and name" do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
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

  it "Displays and links to application pages with action required" do
    @app1 = Application.create!(name: "Dunlap", address: "104 Pine Haven", city: "Colchester", state: "VT", zip: "05446", approved: nil, completed: true)

    @shelter4 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet7 = @shelter4.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet8 = @shelter4.pets.create!(image:"", name: "Loki", description: "dog", approximate_age: 9, sex: "female")

    Adoption.create!(pet_id: @pet7.id, application_id: @app1.id)
    Adoption.create!(pet_id: @pet8.id, application_id: @app1.id)

    visit "/admin/shelters/#{@shelter4.id}"

    expect(page).to have_content("View #{@pet7.name}'s pending adoption")
    expect(page).to have_button("See #{@pet7.name}'s application")

    click_button "See #{@pet7.name}'s application"

    expect(current_path).to eq("/admin/applications/#{@app1.id}")
  end
end