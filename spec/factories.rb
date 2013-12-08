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

    factory :admin do
      admin true
    end
  end

  factory :kid do
    name { Faker::Name.name }
  end

  factory :address do
    street1 { Faker::Address.street_address }
    suburb { Faker::Address.city }
    postcode { Faker::Address.postcode }
    state { Faker::Address.state }
    country { Faker::Address.country }
    addressable { create(:user) }
  end

  factory :tag do
    name { Faker::Lorem.sentence(2) }
    category { Tag::CATEGORIES.sample }
  end

  factory :comment do
    user
    commentable { create(:tag) }
    content 'Rhok'
  end

  factory :resource do
    user
    name { Faker::Lorem.sentence(1) }
    category 'Advocacy'
    url 'http://resource.com'
    phone '+61 1234 567 890'
    facebook 'resource_fb'
    twitter 'resource_tw'
  end

  factory :tagging do
    tag
    taggable factory: :user
  end

  factory :note do
    title { Faker::Lorem.sentence(2) }
    content { Faker::Lorem.sentence(2) }
    user
  end

  factory :group do
    name { Faker::Lorem.sentence(2) }
  end
end
