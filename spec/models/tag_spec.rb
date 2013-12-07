require 'spec_helper'

describe Tag do
  it { should have_many(:users) }
  it { should have_many(:resources) }
end

describe Tag::CATEGORIES do
  it { should equal(['needs', 'symtoms', 'age_group', 'weight_group']) }
end
