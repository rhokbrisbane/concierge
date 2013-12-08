require 'spec_helper'

describe Kid do
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should have_many(:guardianships).dependent(:destroy) }
  it { should have_many(:guardians).through(:guardianships) }
end

