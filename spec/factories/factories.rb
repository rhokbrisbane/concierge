FactoryGirl.define do
  factory :user do

  end

  factory :address do
    street1 { Faker::Address.street_address }
    suburb { Faker::Address.city }
    postcode { Faker::Address.postcode }
    state { Faker::Address.state }
    country { Faker::Address.country }
    addressable { create(:user) }
  end
end
