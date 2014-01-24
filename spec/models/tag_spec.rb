require 'spec_helper'

describe Tag do
  it { should validate_presence_of(:name) }

  it { should have_many(:users) }
  it { should have_many(:resources) }
  it { should have_many(:comments) }

  describe 'Categories' do
    let(:tag) { create :tag }

    it { expect(Tag::CATEGORIES).to include(tag.category) }
  end

  describe '#to_s' do
    let(:tag) { build :tag }

    it 'returns the name' do
      expect(tag.to_s).to eql(tag.name)
    end
  end
end
