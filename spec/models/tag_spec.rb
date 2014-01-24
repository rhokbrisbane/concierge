require 'spec_helper'

describe Tag do
  it { should validate_presence_of(:name) }

  it { should have_many(:users) }
  it { should have_many(:resources) }
  it { should have_many(:comments) }

  describe '#to_s' do
    subject { build :tag }

    it 'returns the name' do
      expect(subject.to_s).to eql(subject.name)
    end
  end
end
