require 'rails_helper'

RSpec.describe 'Admin Shelters index page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
    @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
    visit "/admin/shelters"
  end

  it "Displays the shelters in reverse alphabetical order" do
    expect(page.all(".shelter")[0]).to have_content("#{@shelter2.name}")
    expect(page.all(".shelter")[1]).to have_content("#{@shelter3.name}")
    expect(page.all(".shelter")[2]).to have_content("#{@shelter1.name}")
  end

  it "links to each shelter page" do
    click_link("#{@shelter1.name}")

    expect(current_path).to eq("/admin/shelters/#{@shelter1.id}")
  end
end