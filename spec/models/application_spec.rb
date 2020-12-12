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
  end
end