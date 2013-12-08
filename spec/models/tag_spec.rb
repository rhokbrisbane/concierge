require 'spec_helper'

describe Tag do
  it { should have_many(:users) }
  it { should have_many(:resources) }
end

describe Tag::CATEGORIES do
  let!(:tag) { FactoryGirl.create :tag }
  
  it { should include(tag.category) }
end
