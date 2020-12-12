FactoryBot.define do
  factory :shelter do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr}
    zip { Faker::Address.zip}
  end

  factory :application do
    name { Faker::Name.name_with_middle }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr}
    zip { Faker::Address.zip}
  end
end