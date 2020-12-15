require 'rails_helper'

RSpec.describe 'Application show page' do
  before :each do
    @app1 = Application.create!(name: "Dunlap", street_address: "104 Pine Haven", city: "Colchester", state: "VT", zip: "05446")
    @app2 = Application.create!(name: "Karen", street_address: "15 Quincy", city: "Somerville", state: "MA", zip: "02143")
    @app3 = Application.create!(name: "Ezra", street_address: "14 alley", city: "Greensboro", state: "VT", zip: "09802")

    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
  end

  it 'displays the application with the correct attributes' do

    visit "/applications/#{@app1.id}"

    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.street_address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.state)
    expect(page).to have_content(@app1.zip)
    expect(page).to have_content(@app1.status)
  end

  it 'Can search for and adopt pets' do

    visit "/applications/#{@app1.id}"

    fill_in "search", with: "#{@pet1.name.downcase[0..3]}"

    click_on "search"

    expect(page).to have_content(@pet1.name)

    click_on "adopt this pet"

    within ".info" do
      expect(page).to have_content(@pet1.name)
      expect(page).not_to have_content("Describe")
    end
  end

  it 'Can check for valid submission and submit' do

    visit "/applications/#{@app1.id}"
    fill_in "search", with: "#{@pet1.name.downcase[0..3]}"
    click_on "search"
    click_on "adopt this pet"

    click_on "submit"

    expect(page).to have_content("Please submit once you have described why you are a good choice for these pets")

    fill_in "describe", with: "This is more than ten characters"

    click_on "submit"

    expect(page).to have_content("Pending")
  end

  it 'Can be approved or rejected' do
    visit "/applications/#{@app1.id}"
    fill_in "search", with: "#{@pet1.name.downcase[0..3]}"
    click_on "search"
    click_on "adopt this pet"
    fill_in "describe", with: "This is more than ten characters"

    click_on "submit"
    
    @app1.update(approved: false)
    visit current_path
    expect(page).to have_content("Rejected")
    @app1.update(approved: true)
    visit current_path
    expect(page).to have_content("Approved")
  end
end