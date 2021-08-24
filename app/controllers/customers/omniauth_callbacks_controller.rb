# frozen_string_literal: true

class Customers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  #devise :omniauthable, omniauth_providers: [:google_oauth2]
  #skip_before_action :verify_authenticity_token, only: :facebook
  
  # You should also create an action method in this controller like this:
  # def twitter
  # end


  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @customer = Customer.from_omniauth(request.env['omniauth.auth'])

    if @customer.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @customer, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
      redirect_to new_customer_registration_url, alert: @customer.errors.full_messages.join("\n")
    end
  end

  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @customer = Customer.create_from_provider_data(request.env['omniauth.auth'])

  #   if @customer.persisted?
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Facebook'
  #     sign_in_and_redirect @customer, event: :authentication
  #   else
  #     #session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
  #     redirect_to new_customer_registration_url, alert: @customer.errors.full_messages.join("\n")
  #   end
  # end

  # def facebook
  #   @customer = Customer.from_omniauth(request.env["omniauth.auth"])

  #   if @customer.persisted?
  #     sign_in_and_redirect @customer, event: :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
  #     redirect_to new_customer_registration_url
  #   end
  # end

  def facebook
    
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @customer = Customer.from_omniauth(request.env["omniauth.auth"])
    
    if @customer.persisted?
      sign_in_and_redirect @customer, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_customer_registration_url
    end
  end

  

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

#   def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
#     data = access_token.info
#     @customer = Customer.where(:email => access_token.email, :id => access_token.id ).first
#     if @customer
#       sign_in_and_redirect @customer, event: :authentication
#     else
#       @registered_customer = Customer.where(:email => access_token.info.email).first
#       if @registered_customer
#         return @registered_customer
#       else
#         @customer = Customer.create(name: data["name"],
#           provider:access_token.provider,
#           email: data["email"],
#           uid: access_token.uid ,
#           password: Devise.friendly_token[0,20],
#         )
#       end
#       redirect_to new_customer_registration_path, notice: @customer.errors.full_messages.join("\n")
#    end
#  end
  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   customer = Customer.where(email: data['email']).first

  #   # Uncomment the section below if you want users to be created if they don't exist
  #   unless customer
  #     customer = Customer.create(name: data['name'],
  #         email: data['email'],
  #         password: Devise.friendly_token[0,20]
  #       )
  #   end
  #   customer
  # end

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
