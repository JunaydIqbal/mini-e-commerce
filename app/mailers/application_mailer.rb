class ApplicationMailer < ActionMailer::Base
  default from: 'im.mjunaid.iqbal@gmail.com'
  layout 'mailer'

  # def sent_invitation_email(user)
  #   mail(to: user.email, subject: "Welcome!").tap do |message|
  #     message.mailgun_options = {
  #       "tag" => ["abtest-option-a", "beta-user"],
  #       "tracking-opens" => true,
  #       "tracking-clicks" => "htmlonly"
  #     }
  #   end
  # end

end
