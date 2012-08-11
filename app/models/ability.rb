class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= current_or_guest_user

    can :manage, Todo, :user_id => user.id
  end
end
