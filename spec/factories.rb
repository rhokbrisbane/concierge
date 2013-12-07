FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'foobar123'
  end

  factory :tag do
    name { Faker::Lorem.sentence(2) }
  end
end
