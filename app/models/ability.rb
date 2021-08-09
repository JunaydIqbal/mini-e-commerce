# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    if user.has_role? :vendor

      can :create, Company

      can :update, Company, user_id: user.id
    
      can :destroy, Company, user_id: user.id
      
      #can :manage, Company, user_id: user.id
    elsif user.has_role? :admin
      can :create, Company
      can :manage, Company
      can :update, Company
    
      can :destroy, Company
    
    elsif user.has_role? :employee
      can :show, Company

    elsif user.has_role? :newuser
      can :show, Company

    end

  end

  def initialize(customer)
    if customer.present? 
      can :show, Company
    end
  end

end
