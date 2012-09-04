class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    if user.super_admin?
      can :manage, :all
    elsif user.admin
      can :manage, Article if user.tag_list.include?("article")
      can :index, User if user.tag_list.include?("user_search")
      can [:update, :purview], User, super_admin: [nil, false] if user.tag_list.include?("user_purview")
      can [:entverify, :verify], User if user.tag_list.include?("user_verify")
      can [:entmember, :member], User if user.tag_list.include?("user_member")
    end



    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
