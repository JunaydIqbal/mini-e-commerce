# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(resource)
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
    if resource.is_a?(User)
      if resource.has_role? :vendor
        can :index, Company, user_id: resource.id
        can :list, Company
        can :show, Company, user_id: resource.id
        can :update, Company, user_id: resource.id
        can :destroy, Company, user_id: resource.id
        can :employee, Company, user_id: resource.id
        can :invite, User
        can :create, Product
        can :show, Product
        can :index, Product
        can :update, Product, company_id: resource.company.id
        can :manage, Product, company_id: resource.company.id
        can :destroy, Product, company_id: resource.company.id
        can :add_to_cart, Product
        can :remove_from_cart, Product
      elsif resource.has_role? :admin
        can :create, Company
        can :manage, Company
        can :update, Company
        can :destroy, Company
        can :create, Product
        can :update, Product, company_id: resource.company.id
        can :destroy, Product, company_id: resource.company.id
        can :add_to_cart, Product
        can :remove_from_cart, Product
      elsif resource.has_role? :employee
        can :index, Company, user_id: resource.id
        can :show, Company, user_id: resource.id
        can :list, Company  
        can :employee, Company, user_id: resource.id
        can :create, Product
        can :show, Product
        can :index, Product
        can :search, Product
        can :add_to_cart, Product
        can :remove_from_cart, Product
        can :my_product, Product
        can :manage, Product, user_id: resource.id
      elsif resource.has_role? :newuser
        can :show, Company
      end
    elsif resource.is_a?(Customer)
      can :show, Product
      can :index, Product
      can :list, Company
      can :show, Company
      can :search, Product
      can :add_to_cart, Product
      can :remove_from_cart, Product
    else
      can :show, Product
      can :index, Product
      can :list, Company
      can :show, Company
      can :search, Product
      can :add_to_cart, Product
      can :remove_from_cart, Product
    end
  end
end
