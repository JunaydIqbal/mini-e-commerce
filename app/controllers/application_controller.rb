class ApplicationController < ActionController::Base
  
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def authenticate_inviter!
    send(:"authenticate_#{resource_name}!", force: true).tap do |inviter|
      @current_ability = ::Ability.new(inviter)
      authorize! :invite, User
    end
  end

  # def authenticate!
  #   if current_user.is_a?(User)
  #       :authenticate_user!
  #   elsif current_user.is_a?(Customer)
  #       :authenticate_customer!
  #   end
  # end


  def current_ability
    if customer_signed_in?
      @current_ability ||= Ability.new(current_customer)
    else
      @current_ability ||= Ability.new(current_user)
    end
  end

  private

    def require_login
      unless current_user
        redirect_to new_user_session_path, flash: {error: "Access denied!"}
      end
    end

    def after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :user
        new_user_session_path
      # elsif resource_or_scope == :admin
      #   new_admin_session_path
      else
        root_path
      end
    end

    def after_sign_in_path_for(resource)
      stored_location_for(resource) ||
        if resource.is_a?(User) && resource.has_role?(:vendor)
          edit_company_path(resource.company)
        else
          super
        end
        
    end

end
