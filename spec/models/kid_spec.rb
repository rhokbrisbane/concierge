require 'spec_helper'

describe Kid do
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
end
