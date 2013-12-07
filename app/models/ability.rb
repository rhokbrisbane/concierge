class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Resource
  end
end
