require 'spec_helper'

describe User do
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should have_many(:guardianships).dependent(:destroy) }
  it { should have_many(:kids).through(:guardianships) }
  it { should have_many(:comments) }
end

