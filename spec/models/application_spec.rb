require 'rails_helper'

describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :adoptions && :pets}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :street_address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
  end

  describe 'instance methods' do
    describe '.status' do
      it 'can update the status' do
        app = Application.create(name: "Jem", street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip)

        expect(app.status).to eq("In Progress")

        app.update(completed: true)

        expect(app.status).to eq("Pending")

        app.update(approved: false)

        expect(app.status).to eq("Rejected")

        app.update(approved: true)

        expect(app.status).to eq("Approved")
      end
    end

    describe '.address' do
      it 'can group the address' do
        app = Application.create(name: "Jem", street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip)

        expect(app.address).to eq("#{app.street_address} #{app.city}, #{app.state} #{app.zip}")
      end
    end

    it "Can claim pets" do
      @app1 = Application.create!(name: "Dunlap", street_address: "104 Pine Haven", city: "Colchester", state: "VT", zip: "05446")
      @app2 = Application.create!(name: "Karen", street_address: "15 Quincy", city: "Somerville", state: "MA", zip: "02143")
      @app3 = Application.create!(name: "Ezra", street_address: "14 alley", city: "Greensboro", state: "VT", zip: "09802")

      @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
      @pet2 = @shelter1.pets.create!(image:"", name: "Loki", description: "dog", approximate_age: 9, sex: "female")

      Adoption.create!(pet_id: @pet1.id, application_id: @app1.id)
      Adoption.create!(pet_id: @pet2.id, application_id: @app1.id)
      Adoption.create!(pet_id: @pet1.id, application_id: @app2.id)

      @app1.claim_pets

      @pet1.reload

      expect(@pet1.adoptable).to eq(false)
    end
  end

  describe 'Class Methods' do
    describe 'Search' do
      it 'can search by name' do
        app = Application.create(name: "Jem", street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip)

        FactoryBot.create_list(:application, 5)

        expect(Application.search("abcdefg").first).to eq(nil)
        expect(Application.search("Jem").first).to eq(app)
      end
    end
  end
end