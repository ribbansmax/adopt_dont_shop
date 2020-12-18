require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
  end

  it 'can list all shelters with pending applications' do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
    @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)

    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")

    @app1 = Application.create!(name: "Dunlap", address: "104 Pine Haven", city: "Colchester", state: "VT", zip: "05446")
    @app2 = Application.create!(name: "Karen", address: "15 Quincy", city: "Somerville", state: "MA", zip: "02143")

    @a1 = Adoption.create!(pet_id: @pet1.id, application_id: @app1.id)
    @a2 = Adoption.create!(pet_id: @pet2.id, application_id: @app1.id)

    @app1.update!(completed: true)
    @app2.update!(completed: true)

    expect(Shelter.pending).to eq([@shelter1, @shelter2])
  end

  it 'Can calculate the average age of pets' do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")

    expect(@shelter1.average_pet_age).to eq(3)
  end

  it "Can count number of adopted and adoptable pets" do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")

    expect(@shelter1.adopted_pets).to eq(0)
    expect(@shelter1.adoptable_pets).to eq(3)
  end

  it "can return pending pets" do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")

    @app1 = Application.create!(name: "Dunlap", address: "104 Pine Haven", city: "Colchester", state: "VT", zip: "05446", approved: nil, completed: true)

    Adoption.create!(pet_id: @pet1.id, application_id: @app1.id)
    Adoption.create!(pet_id: @pet2.id, application_id: @app1.id)

    pending_pets = @shelter1.pending_pets
    expect(pending_pets.first).to eq(@pet1)
  end
end
