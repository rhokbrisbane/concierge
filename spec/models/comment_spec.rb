require 'spec_helper'

describe Comment do
  it { should belong_to(:commentable) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }
  it { should validate_presence_of(:content) }
  it { should allow_value('Resource').for(:commentable_type) }
  it { should allow_value('Tag').for(:commentable_type) }
  it { should allow_value('User').for(:commentable_type) }
  it { should_not allow_value('Group').for(:commentable_type) }

  describe 'default scope' do
    let!(:comment1) { create(:comment, created_at: Time.now) }
    let!(:comment2) { create(:comment, created_at: Time.now.yesterday) }

    it 'fetches ordered by created at' do
      expect(described_class.all.to_a).to eql([comment2, comment1])
    end
  end
end
