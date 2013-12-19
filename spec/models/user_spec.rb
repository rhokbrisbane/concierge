require 'spec_helper'

describe User do
  it { should have_and_belong_to_many(:groups) }

  it { should have_one(:address) }

  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should have_many(:resources) }
  it { should have_many(:guardianships).dependent(:destroy) }
  it { should have_many(:kids).through(:guardianships) }
  it { should have_many(:comments) }
end
