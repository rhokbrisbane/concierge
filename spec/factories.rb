FactoryGirl.define do
  factory :address do
    street1     { Faker::Address.street_address }
    suburb      { Faker::Address.city }
    postcode    { Faker::Address.postcode }
    state       { Faker::Address.state }
    country     { Faker::Address.country }
    addressable { build_stubbed(:user) }

  end

  factory :ne_address, parent: :address do
    street1     { "7 Prospect St" }
    suburb      { "Fortitude Valley" }
    postcode    { "4006" }
    state       { "Queensland" }
    country     { "Australia" }
  end

  factory :alaska_library_address, parent: :address do
    street1     { "1 Main st" }
    suburb      { "Akiachak" }
    postcode    { "99551" }
    state       { "Alaska" }
    country     { "USA" }
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'rhok2013'

    factory :close_user do
      sequence(:name) { |n| "Close User #{n}" }
      after(:build) do |u|
        u.addresses.build attributes_for(:ne_address).merge(addressable: u)
      end
    end

    factory :far_user do
      sequence(:name) { |n| "Far User #{n}" }

      after :build do |u|
        u.addresses.build attributes_for(:alaska_library_address).merge(addressable: u)
      end
    end

    factory(:admin) { admin true }
  end

  factory :kid do
    name { Faker::Name.name }
  end

  factory :tag do
    name     { Faker::Lorem.sentence(2) }
    category { Tag::CATEGORIES.sample }
  end

  factory :comment do
    user
    commentable { build_stubbed(:tag) }
    content 'Rhok'
  end

  factory :resource do
    user
    name     { Faker::Lorem.sentence(1) }
    category ResourcesCategory::ADVOCACY
    url      'http://resource.com'
    phone    '+61 1234 567 890'
    facebook 'resource_fb'
    twitter  'resource_tw'

  end

  factory :saved_search do
    user
    name { Faker::Lorem.sentence(1) }
  end

  factory :tagging do
    tag
    taggable factory: :user
  end

  factory :note do
    title   { Faker::Lorem.sentence(2) }
    content { Faker::Lorem.sentence(2) }
    user
  end

  factory :group do
    name { Faker::Lorem.sentence(2) }
  end
end
