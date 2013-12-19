require 'spec_helper'

describe Resource do
  it { should belong_to(:user) }

  it { should have_one(:address) }

  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should have_many(:comments) }

  describe '#to_s' do
    let(:resource) { build :resource }

    it 'returns the name' do
      expect(resource.to_s).to eql(resource.name)
    end
  end
end
