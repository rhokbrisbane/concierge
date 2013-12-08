class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    cannot :manage, :all

    can :manage, :all if user.admin?

    can :create, Tagging
    can :create, Resource
    can :create, Note
    can :create, Kid
    can :create, SavedSearch

    can :read, Group
    can :read, Address
    can :read, Tag
    can :read, Tagging
    can :read, Comment

    can :read, Note do |note|
      note.group_shares.where(shared_group_id: user.group_ids).any? ||
      note.user_shares.where(shared_user_id: user.id).any?
    end

    can :read, Resource do |resource|
      resource.group_shares.where(shared_group_id: user.group_ids).any? ||
      resource.user_shares.where(shared_user_id: user.id).any?
    end

    can :read, User do |other_user|
      other_user.group_shares.where(shared_group_id: user.group_ids).any? ||
      other_user.user_shares.where(shared_user_id: user.id).any?
    end

    can :read, Kid do |kid|
      kid.group_shares.where(shared_group_id: user.group_ids).any? ||
      kid.user_shares.where(shared_user_id: user.id).any?
    end

    can :read, User, id: user.id
    can :delete, User, id: user.id
    can :manage, User, id: user.id

    can :manage, Note, user_id: user.id
    can :manage, Resource, user_id: user.id
    can :manage, Tagging, user_id: user.id
    can :manage, Address, user_id: user.id
    can :manage, SavedSearch, user_id: user.id
    can :manage, Comment, user_id: user.id
    can :manage, Kid do |kid|
      kid.guardianships.where(user_id: user.id).any?
    end
  end
end
