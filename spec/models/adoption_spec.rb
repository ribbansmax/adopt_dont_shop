require 'rails_helper'

RSpec.describe Adoption, type: :model do
  before :each do
    @app1 = Application.create!(name: "Dunlap", street_address: "104 Pine Haven", city: "Colchester", state: "VT", zip: "05446")
    @app2 = Application.create!(name: "Karen", street_address: "15 Quincy", city: "Somerville", state: "MA", zip: "02143")
    @app3 = Application.create!(name: "Ezra", street_address: "14 alley", city: "Greensboro", state: "VT", zip: "09802")

    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Loki", description: "dog", approximate_age: 9, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Odin", description: "dog", approximate_age: 9, sex: "male")


    @a1 = Adoption.create!(pet_id: @pet1.id, application_id: @app1.id)
    @a2 = Adoption.create!(pet_id: @pet2.id, application_id: @app1.id)
    @a3 = Adoption.create!(pet_id: @pet3.id, application_id: @app2.id)
  end

  it "Can update status of an app" do
    expect(Adoption.status(@app1.id)).to eq("Pending")

    @a1.update!(approved: true)
    @a2.update!(approved: true)

    expect(Adoption.status(@app1.id)).to eq("Approved")

    @a3.update!(approved: false)

    expect(Adoption.status(@app2.id)).to eq("Rejected")
  end
end