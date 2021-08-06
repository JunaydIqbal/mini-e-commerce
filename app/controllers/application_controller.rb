class ApplicationController < ActionController::Base
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
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
        if resource.is_a?(User) && resource.company == nil
          new_company_path
        else
          super
        end
    end



end
