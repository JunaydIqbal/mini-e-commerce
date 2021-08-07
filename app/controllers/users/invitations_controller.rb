class Users::InvitationsController < Devise::InvitationsController
  def update
    
      super
    
  end

  # def invite_resource
  #   # skip sending emails on invite
  #   super { |user| user.skip_invitation = false }
    
  # end

  
  
end