require 'rails_helper'

RSpec.describe 'Admin Application show page' do
  before :each do
    @app1 = Application.create!(name: "Dunlap", street_address: "104 Pine Haven", city: "Colchester", state: "VT", zip: "05446")
    @app2 = Application.create!(name: "Karen", street_address: "15 Quincy", city: "Somerville", state: "MA", zip: "02143")
    @app3 = Application.create!(name: "Ezra", street_address: "14 alley", city: "Greensboro", state: "VT", zip: "09802")

    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Loki", description: "dog", approximate_age: 9, sex: "female")

    Adoption.create!(pet_id: @pet1.id, application_id: @app1.id)
    Adoption.create!(pet_id: @pet2.id, application_id: @app1.id)
    Adoption.create!(pet_id: @pet1.id, application_id: @app2.id)
  end

  it "Can approve adoption" do
    visit "/admin/applications/#{@app1.id}"

    expect(page).to have_button("#{@pet1.name}")

    click_button "#{@pet1.name}"

    expect(current_path).to eq "/admin/applications/#{@app1.id}"
    expect(page).to have_no_button("#{@pet1.name}")
    expect(page).to have_content("#{@pet1.name} is approved")
  end
end