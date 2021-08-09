class Users::InvitationsController < Devise::InvitationsController
  def update
    
      super
    
  end

  # def invite_resource
  #   # skip sending emails on invite
  #   super { |user| user.skip_invitation = false }
    
  # end

  
  # def destroy
  #   resource.destroy
  #   set_flash_message :notice, :invitation_removed if is_flashing_format?
  #   redirect_to after_sign_out_path_for(resource_name)

  # end


end