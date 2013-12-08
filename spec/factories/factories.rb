FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'rhok2013'

    factory :close_user do
      name "Close User"
      after(:build) do |u|
        u.addresses.build street1:     "7 prospect st",
                          suburb:      "Fortitude Valley",
                          postcode:    "4006",
                          state:       "QLD",
                          country:     "AU",
                          latitude:    -27.4521756,
                          longitude:   153.0374968,
                          addressable: u
      end
    end

    factory :far_user do
      name "Far User"
      after(:build) do |u|
        u.addresses.build street1:     "1 Main st",
                          suburb:      "Akiachak",
                          postcode:    "99551",
                          state:       "Alaska",
                          country:     "USA",
                          latitude:    60.89944999999999,
                          longitude:   -161.413426,
                          addressable: u
      end
    end
  end

  factory :address do
    street1 { Faker::Address.street_address }
    suburb { Faker::Address.city }
    postcode { Faker::Address.postcode }
    state { Faker::Address.state }
    country { Faker::Address.country }
    addressable { create(:user) }
  end

  categories = Tag::CATEGORIES

  factory :tag do
    name { Faker::Lorem.sentence(2) }
    category { categories[rand(0..categories.length)] }
  end
end
