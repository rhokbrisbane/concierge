require 'spec_helper'

describe SavedSearch do
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }

  it { should belong_to(:user).dependent(:destroy) }
end
