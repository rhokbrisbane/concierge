require 'spec_helper'

describe Tag do
  it { should have_many(:users) }
  it { should have_many(:resources) }
  it { should have_many(:comments) }

  describe 'Categories' do
    let(:tag) { create(:tag) }

    it { expect(Tag::CATEGORIES).to include(tag.category) }
  end
end
