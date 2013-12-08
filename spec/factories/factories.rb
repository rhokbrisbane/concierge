FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'rhok2013'
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
