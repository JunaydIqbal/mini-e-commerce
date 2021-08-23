class FormForMailer < ApplicationMailer
  default :from => 'eizelhomee@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_invitation_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Invitation for Employee of E-Shopper' )
  end

end
