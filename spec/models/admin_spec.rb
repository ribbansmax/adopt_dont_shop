require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe "It can alter pet attributes" do
    it 'can approve pets for adoptions' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
      app = Application.create!(name: "Jem", street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip)

      adoption = Adoption.create!(pet_id: pet.id, application_id: app.id)

      expect(pet.adoptable).to eq(true)
      Admin.approve(adoption)
      # binding.pry
      pet.reload
      puts pet.adoptable

      expect(pet.adoptable).to eq(false)
    end
  end
end