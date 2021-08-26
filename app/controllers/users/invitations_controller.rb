class Users::InvitationsController < Devise::InvitationsController

  before_action :is_vendor?, :only => [:new, :create]
  
  def new
    super
    
  end

  def create

    super 
    # do |created_user|
    #   if created_user.id
    #     @user = created_user
    #     ApplicationMailer.sent_invitation_email(@user).deliver
            
    #   end
    # end

    
    # self.resource = invite_resource
    # resource_invited = resource.errors.empty?
    # yield resource if block_given?

    # if resource_invited
    #   if is_flashing_format? && self.resource.invitation_sent_at
    #     set_flash_message :notice, :send_instructions, email: self.resource.email
    #   end
    #   # if self.method(:after_invite_path_for).arity == 1
    #   #   redirect_to employees_path
    #   # else
    #   #   #respond_with resource, location: after_invite_path_for(current_inviter, resource)
    #   #   redirect_to employees_path
    #   # end
    # else
    #   redirect_to employees_path, alert: resource.errors.full_messages.join
    #   # respond_with_navigational(resource) { render :new }
    # end
    
  end

  # def invite_resource(&block)
  #   resource_class.invite!(invite_params, current_inviter, &block)
  # end

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