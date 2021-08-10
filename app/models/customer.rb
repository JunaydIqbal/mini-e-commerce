class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :username,  presence: true, length: { maximum: 15 }, format: { without: /\s/ }
  validates_uniqueness_of   :username
  validates_uniqueness_of   :phone

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |customer|
  #     customer.provider = auth.provider
  #     customer.uid = auth.uid
  #     full_name = auth.info.name.split(" ")
  #     customer.first_name = full_name[0]
  #     customer.last_name = full_name[1]
  #     customer.email = auth.info.email
  #     customer.oauth_token = auth.credentials.token
  #     customer.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     customer.save!
  #   end
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

end
