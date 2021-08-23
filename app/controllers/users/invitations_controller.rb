class Users::InvitationsController < Devise::InvitationsController

  before_action :is_vendor?, :only => [:new, :create]
  
  def new
    super
    
  end

  def create
    
    super
    FormForMailer.send_invitation_email(@user).deliver
  end

  def update
    super
  end

  # def invite_resource
  #   # skip sending emails on invite
  #   super { |user| user.skip_invitation = false }
    
  # end

  private
    
    def is_vendor?
      current_user.roles.first.name == 'vendor'
    end
  # def destroy
  #   resource.destroy
  #   set_flash_message :notice, :invitation_removed if is_flashing_format?
  #   redirect_to after_sign_out_path_for(resource_name)

  # end
end