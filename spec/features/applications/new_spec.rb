require 'rails_helper'

RSpec.describe 'Create new Application' do
  it 'should create a new Application' do
    visit "applications/new"

    fill_in "name", with: 'Jim'
    fill_in "street_address", with: 'road avenue'
    fill_in "city", with: 'Pitt'
    fill_in "state", with: ''
    fill_in "zip", with: 12345

    click_on "create"

    expect(current_path).to eq('/applications/new')

    expect(page).to have_content("Application is missing: state")

    fill_in "name", with: 'Jim'
    fill_in "street_address", with: 'road avenue'
    fill_in "city", with: 'Pitt'
    fill_in "state", with: 'PA'
    fill_in "zip", with: 12345

    click_on "create"

    expect(page).to have_content("In Progress")
    expect(page).to have_content("Jim")
    expect(page).to have_content("road avenue")
    expect(page).to have_content("Pitt")
    expect(page).to have_content("PA")
  end
end