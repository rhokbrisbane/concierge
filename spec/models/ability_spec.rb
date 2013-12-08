require "spec_helper"
require "cancan/matchers"

describe Ability do
  context "when non admin" do
    let(:user) { create(:user) }
    let(:ability) { Ability.new(user) }

    subject { ability }

    context "and the user is a member of group 'A'" do
      let(:group_a) { create(:group) }

      before(:each) do
        user.groups << group_a
      end

      context "when created by user" do
        let(:note) { create(:note, user: user) }
        let(:resource) { create(:resource, user: user) }
        let(:tagging) { create(:tagging, user: user) }
        let(:address) { create(:address, user: user) }
        let(:kid) { create(:kid) }

        before(:each) do
          kid.guardians << user
        end

        it "should be_able_to(:read, kid)" do
          should be_able_to(:read, kid)
        end

        it "should be_able_to(:update, kid)" do
          should be_able_to(:update, kid)
        end

        it "should be_able_to(:delete, kid)" do
          should be_able_to(:delete, kid)
        end

        it "should be_able_to(:read, tagging)" do
          should be_able_to(:read, tagging)
        end

        it "should be_able_to(:update, tagging)" do
          should be_able_to(:update, tagging)
        end

        it "should be_able_to(:delete, tagging)" do
          should be_able_to(:delete, tagging)
        end

        it "should be_able_to(:read, note)" do
          should be_able_to(:read, note)
        end

        it "should be_able_to(:update, note)" do
          should be_able_to(:update, note)
        end

        it "should be_able_to(:delete, note)" do
          should be_able_to(:delete, note)
        end


        it "should be_able_to(:read, user)" do
          should be_able_to(:read, user)
        end

        it "should be_able_to(:update, user)" do
          should be_able_to(:update, user)
        end

        it "should be_able_to(:delete, user)" do
          should be_able_to(:delete, user)
        end

        it "should be_able_to(:read, resource)" do
          should be_able_to(:read, resource)
        end

        it "should be_able_to(:update, resource)" do
          should be_able_to(:update, resource)
        end

        it "should be_able_to(:delete, resource)" do
          should be_able_to(:delete, resource)
        end

        it "should be_able_to(:read, address)" do
          should be_able_to(:read, address)
        end

        it "should be_able_to(:update, address)" do
          should be_able_to(:update, address)
        end

        it "should be_able_to(:delete, address)" do
          should be_able_to(:delete, address)
        end
      end

      context "when shared with user" do
        let(:note) { create(:note) }
        let(:resource) { create(:resource) }
        let(:other_user) { create(:user) }
        let(:kid) { create(:kid) }

        before(:each) do
          note.shared_users << user
          other_user.shared_users << user
          resource.shared_users << user
          kid.shared_users << user
        end

        it "should be_able_to(:read, kid)" do
          should be_able_to(:read, kid)
        end

        it "should_not be_able_to(:update, kid)" do
          should_not be_able_to(:update, kid)
        end

        it "should_not be_able_to(:delete, kid)" do
          should_not be_able_to(:delete, kid)
        end

        it "should be_able_to(:read, note)" do
          should be_able_to(:read, note)
        end

        it "should_not be_able_to(:update, note)" do
          should_not be_able_to(:update, note)
        end

        it "should_not be_able_to(:delete, note)" do
          should_not be_able_to(:delete, note)
        end

        it "should be_able_to(:read, other_user)" do
          should be_able_to(:read, other_user)
        end

        it "should_not be_able_to(:update, other_user)" do
          should_not be_able_to(:update, other_user)
        end

        it "should_not be_able_to(:delete, other_user)" do
          should_not be_able_to(:delete, other_user)
        end

        it "should be_able_to(:read, resource)" do
          should be_able_to(:read, resource)
        end

        it "should_not be_able_to(:update, resource)" do
          should_not be_able_to(:update, resource)
        end

        it "should_not be_able_to(:delete, resource)" do
          should_not be_able_to(:delete, resource)
        end
      end

      context "when shared with group 'A'" do
        let(:note) { create(:note) }
        let(:resource) { create(:resource) }
        let(:other_user) { create(:user) }
        let(:kid) { create(:kid) }

        before(:each) do
          note.shared_groups << group_a
          other_user.shared_groups << group_a
          resource.shared_groups << group_a
          kid.shared_groups << group_a
        end

        it "should be_able_to(:read, kid)" do
          should be_able_to(:read, kid)
        end

        it "should_not be_able_to(:update, kid)" do
          should_not be_able_to(:update, kid)
        end

        it "should_not be_able_to(:delete, kid)" do
          should_not be_able_to(:delete, kid)
        end

        it "should be_able_to(:read, note)" do
          should be_able_to(:read, note)
        end

        it "should_not be_able_to(:update, note)" do
          should_not be_able_to(:update, note)
        end

        it "should_not be_able_to(:delete, note)" do
          should_not be_able_to(:delete, note)
        end

        it "should be_able_to(:read, other_user)" do
          should be_able_to(:read, other_user)
        end

        it "should_not be_able_to(:update, other_user)" do
          should_not be_able_to(:update, other_user)
        end

        it "should_not be_able_to(:delete, other_user)" do
          should_not be_able_to(:delete, other_user)
        end

        it "should be_able_to(:read, resource)" do
          should be_able_to(:read, resource)
        end

        it "should_not be_able_to(:update, resource)" do
          should_not be_able_to(:update, resource)
        end

        it "should_not be_able_to(:delete, resource)" do
          should_not be_able_to(:delete, resource)
        end
      end

      context "when not shared or created by user" do
        let(:note) { create(:note) }
        let(:other_user) { create(:user) }
        let(:group) { create(:group) }
        let(:tag) { create(:tag) }
        let(:tagging) { create(:tagging) }
        let(:resource) { create(:resource) }
        let(:address) { create(:address) }
        let(:kid) { create(:kid) }

        it "should_not be_able_to(:read, kid)" do
          should_not be_able_to(:read, kid)
        end

        it "should_not be_able_to(:update, kid)" do
          should_not be_able_to(:update, kid)
        end

        it "should_not be_able_to(:delete, kid)" do
          should_not be_able_to(:delete, kid)
        end

        it "should be_able_to(:read, group)" do
          should be_able_to(:read, group)
        end

        it "should_not be_able_to(:update, group)" do
          should_not be_able_to(:update, group)
        end

        it "should_not be_able_to(:delete, group)" do
          should_not be_able_to(:delete, group)
        end

        it "should be_able_to(:read, tag)" do
          should be_able_to(:read, tag)
        end

        it "should_not be_able_to(:update, tag)" do
          should_not be_able_to(:update, tag)
        end

        it "should_not be_able_to(:delete, tag)" do
          should_not be_able_to(:delete, tag)
        end

        it "should be_able_to(:read, tagging)" do
          should be_able_to(:read, tagging)
        end

        it "should_not be_able_to(:update, tagging)" do
          should_not be_able_to(:update, tagging)
        end

        it "should_not be_able_to(:delete, tagging)" do
          should_not be_able_to(:delete, tagging)
        end

        it "should_not be_able_to(:read, note)" do
          should_not be_able_to(:read, note)
        end

        it "should_not be_able_to(:update, note)" do
          should_not be_able_to(:update, note)
        end

        it "should_not be_able_to(:delete, note)" do
          should_not be_able_to(:delete, note)
        end

        it "should_not be_able_to(:read, other_user)" do
          should_not be_able_to(:read, other_user)
        end

        it "should_not be_able_to(:update, other_user)" do
          should_not be_able_to(:update, other_user)
        end

        it "should_not be_able_to(:delete, other_user)" do
          should_not be_able_to(:delete, other_user)
        end

        it "should_not be_able_to(:read, resource)" do
          should_not be_able_to(:read, resource)
        end

        it "should_not be_able_to(:update, resource)" do
          should_not be_able_to(:update, resource)
        end

        it "should_not be_able_to(:delete, resource)" do
          should_not be_able_to(:delete, resource)
        end

        it "should be_able_to(:read, address)" do
          should be_able_to(:read, address)
        end

        it "should_not be_able_to(:update, address)" do
          should_not be_able_to(:update, address)
        end

        it "should_not be_able_to(:delete, address)" do
          should_not be_able_to(:delete, address)
        end
      end

      context "creation" do
        it "should_not be_able_to(:create, Group)" do
          should_not be_able_to(:create, Group)
        end

        it "should_not be_able_to(:create, Tag)" do
          should_not be_able_to(:create, Tag)
        end

        it "should be_able_to(:create, Tagging)" do
          should be_able_to(:create, Tagging)
        end

        it "should be_able_to(:create, Note)" do
          should be_able_to(:create, Note)
        end

        it "should_not be_able_to(:create, User)" do
          should_not be_able_to(:create, User)
        end

        it "should be_able_to(:create, Resource)" do
          should be_able_to(:create, Resource)
        end

        it "should be_able_to(:create, Address)" do
          should be_able_to(:create, Address)
        end

        it "should be_able_to(:create, Kid)" do
          should be_able_to(:create, Kid)
        end

        it "should be_able_to(:create, SavedSearch)" do
          should be_able_to(:create, SavedSearch)
        end

        it "should be_able_to(:create, Comment)" do
          should be_able_to(:create, Comment)
        end
      end
    end
  end
end
