# frozen_string_literal: true

class Customers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  #devise :omniauthable, omniauth_providers: [:google_oauth2]
  
  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # def google_oauth2
  #   handle_auth("Google")
  # end

  # def handle_auth(kind)
  #   @customer = Customer.from_omniauth(request.env['omniauth.auth'])
  #   if @customer.persisted?
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: kind
  #     sign_in_and_redirect @customer, event: :authentication
  #   else
  #     session['devise.auth_data'] = request.env['omniauth.auth'].except('extra')
  #     redirect_to new_customer_registration_path, notice: @customer.errors.full_messages.join("\n")
  #   end

  # end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    @customer = Customer.where(:email => access_token.email, :id => access_token.id ).first
    
    if @customer
      sign_in_and_redirect @customer, event: :authentication
    else
      @registered_customer = Customer.where(:email => access_token.info.email).first
      if @registered_customer
        return @registered_customer
      else
        @customer = Customer.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
        )
      end
      redirect_to new_customer_registration_path, notice: @customer.errors.full_messages.join("\n")
   end
 end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
