require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  context 'when non admin' do
    let(:user) { create :user }
    let(:ability) { Ability.new(user) }

    subject { ability }

    context 'and the user is a member of group A' do
      let(:group_a) { create :group }

      before { user.groups << group_a }

      context 'when created by user' do
        let(:note)     { create :note,     user: user }
        let(:resource) { create :resource, user: user }
        let(:tagging)  { create :tagging,  user: user }
        let(:address)  { create :address,  addressable: user }
        let(:kid)      { create :kid }

        before { kid.guardians << user }

        it { should be_able_to(:read,    kid) }
        it { should be_able_to(:update,  kid) }
        it { should be_able_to(:delete,  kid) }
        it { should be_able_to(:read,    tagging) }
        it { should be_able_to(:update,  tagging) }
        it { should be_able_to(:delete,  tagging) }
        it { should be_able_to(:read,    note) }
        it { should be_able_to(:update,  note) }
        it { should be_able_to(:delete,  note) }
        it { should be_able_to(:read,    user) }
        # it { should be_able_to(:update,  user) }
        # it { should be_able_to(:delete,  user) }
        it { should be_able_to(:read,    resource) }
        it { should be_able_to(:update,  resource) }
        it { should be_able_to(:delete,  resource) }
        it { should be_able_to(:read,    address) }
        it { should be_able_to(:update,  address) }
        it { should be_able_to(:delete,  address) }
      end

      context 'when shared with user' do
        let(:note)       { create :note }
        let(:resource)   { create :resource }
        let(:other_user) { create :user }
        let(:kid)        { create :kid }

        before do
          note.shared_users       << user
          other_user.shared_users << user
          resource.shared_users   << user
          kid.shared_users        << user
        end

        it { should     be_able_to(:read,    kid) }
        it { should_not be_able_to(:update,  kid) }
        it { should_not be_able_to(:delete,  kid) }
        it { should     be_able_to(:read,    note) }
        it { should_not be_able_to(:update,  note) }
        it { should_not be_able_to(:delete,  note) }
        it { should     be_able_to(:read,    other_user) }
        it { should_not be_able_to(:update,  other_user) }
        it { should_not be_able_to(:delete,  other_user) }
        it { should     be_able_to(:read,    resource) }
        it { should_not be_able_to(:update,  resource) }
        it { should_not be_able_to(:delete,  resource) }
      end

      context 'when shared with group A' do
        let(:note)       { create :note }
        let(:resource)   { create :resource }
        let(:other_user) { create :user }
        let(:kid)        { create :kid }

        before do
          note.shared_groups << group_a
          other_user.shared_groups << group_a
          resource.shared_groups << group_a
          kid.shared_groups << group_a
        end

        it { should     be_able_to(:read,    kid) }
        it { should_not be_able_to(:update,  kid) }
        it { should_not be_able_to(:delete,  kid) }
        it { should     be_able_to(:read,    note) }
        it { should_not be_able_to(:update,  note) }
        it { should_not be_able_to(:delete,  note) }
        it { should     be_able_to(:read,    other_user) }
        it { should_not be_able_to(:update,  other_user) }
        it { should_not be_able_to(:delete,  other_user) }
        it { should     be_able_to(:read,    resource) }
        it { should_not be_able_to(:update,  resource) }
        it { should_not be_able_to(:delete,  resource) }
      end

      context 'when not shared or created by user' do
        let(:note)       { create :note }
        let(:other_user) { create :user }
        let(:group)      { create :group }
        let(:tag)        { create :tag }
        let(:tagging)    { create :tagging }
        let(:resource)   { create :resource }
        let(:address)    { create :address }
        let(:kid)        { create :kid }

        # it { should_not be_able_to(:read,    kid) }
        it { should_not be_able_to(:update,  kid) }
        it { should_not be_able_to(:delete,  kid) }
        it { should     be_able_to(:read,    group) }
        it { should_not be_able_to(:update,  group) }
        it { should_not be_able_to(:delete,  group) }
        it { should     be_able_to(:read,    tag) }
        it { should_not be_able_to(:update,  tag) }
        it { should_not be_able_to(:delete,  tag) }
        it { should     be_able_to(:read,    tagging) }
        it { should_not be_able_to(:update,  tagging) }
        it { should_not be_able_to(:delete,  tagging) }
        # it { should_not be_able_to(:read,    note) }
        it { should_not be_able_to(:update,  note) }
        it { should_not be_able_to(:delete,  note) }
        # it { should_not be_able_to(:read,    other_user) }
        it { should_not be_able_to(:update,  other_user) }
        it { should_not be_able_to(:delete,  other_user) }
        # it { should_not be_able_to(:read,    resource) }
        it { should_not be_able_to(:update,  resource) }
        it { should_not be_able_to(:delete,  resource) }
        it { should     be_able_to(:read,    address) }
        it { should_not be_able_to(:update,  address) }
        it { should_not be_able_to(:delete,  address) }
      end

      context 'creation' do
        it { should_not be_able_to(:create, Group) }
        it { should_not be_able_to(:create, Tag) }
        it { should     be_able_to(:create, Tagging) }
        it { should     be_able_to(:create, Note) }
        it { should_not be_able_to(:create, User) }
        it { should     be_able_to(:create, Resource) }
        it { should     be_able_to(:create, Address) }
        it { should     be_able_to(:create, Kid) }
        it { should     be_able_to(:create, SavedSearch) }
        it { should     be_able_to(:create, Comment) }
      end
    end
  end
end
