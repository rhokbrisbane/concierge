require 'factory_girl'

FactoryGirl.define do
  factory :resource do
    name { Faker::Name.name }
    content 'Lorem ipsum dolor sit amet, consectetur adipisicing elit'
  end
end
