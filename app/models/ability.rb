# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    if user.admin?
      can :manage, :all
    else
      can :manage, Post, author_id: user.id
      can :read, :all
    end
  end
end
