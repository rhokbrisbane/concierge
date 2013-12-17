require 'spec_helper'

describe SavedSearch do
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }

  it { should belong_to(:user).dependent(:destroy) }

  describe '#to_s' do
    let(:saved_search) { build :saved_search }

    it 'returns the name' do
      expect(saved_search.to_s).to eql(saved_search.name)
    end
  end
end
