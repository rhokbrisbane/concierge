require 'spec_helper'

describe SavedSearch do
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
end
