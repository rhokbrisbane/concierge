require 'spec_helper'

describe Tag do
  it { should have_many(:users) }
  it { should have_many(:resources) }

  describe 'categories' do
    let(:tag) { create(:tag) }

    it { expect(Tag::CATEGORIES).to include(tag.category) }
  end
end
