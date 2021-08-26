class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  validates :username,  presence: true, length: { maximum: 15 }, format: { without: /\s/ }
  validates_uniqueness_of   :username
  validates_uniqueness_of   :phone



  def self.from_omniauth(access_token)
    data = access_token.info
    #customer = Customer.where(email: data['email']).first
    
    # # Uncomment the section below if you want users to be created if they don't exist
    # unless customer
    #   customer = Customer.create(username: data['name'].length > 15 ? data['name'].slice(0..14).gsub(/\s+/, "") : data['name'].gsub(/\s+/, ""),
    #        email: data['email'],
    #        phone: data['phone'],
    #        name: data['name'],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    # customer.cid = data['uid']
    # customer.provider = data['provider']
    # customer.save
    where(provider: data.provider, cid: data.cid).first_or_create do |cust|
      cust.email = data.email
      cust.username = data.name.length > 15 ? data.name.slice(0..14).gsub(/\s+/, "") : data.name.gsub(/\s+/, "")
      cust.name = data.name
      cust.password = Devise.friendly_token[0,20]
      cust.save
    end
  end

  def to_s
    email
  end

  after_create do
    customer = Stripe::Customer.create(email: email, phone: phone, username: username)
    update(stripe_customer_id: customer.id)
  end

  

  # def self.from_fb_omniauth(auth)
  #   customer = Customer.where(email: auth.info.email).first

  #   if customer
  #     return customer
  #   else
  #     where(provider: auth.provider, cid: auth.cid).first_or_create do |customer|
  #       customer.email = auth.info.email
  #       customer.password = Devise.friendly_token[0, 20]
  #       customer.name = auth.info.name   # assuming the user model has a name
  #       # If you are using confirmable and the provider(s) you use validate emails, 
  #       # uncomment the line below to skip the confirmation emails.
  #       # user.skip_confirmation!
  #       customer.cid = customer.cid
  #       customer.provider = customer.provider
  #     end
  #   end
  # end
  


  


  # def self.create_from_provider_data(provider_data)
  #   where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |customer|
  #     customer.email = provider_data.info.email
  #     customer.password = Devise.friendly_token[0,20]
  #   end
  # end

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

  # def google_oauth2
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @customer = Customer.from_omniauth(request.env['omniauth.auth'])

  #   if @customer.persisted?
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
  #     sign_in_and_redirect @customer, event: :authentication
  #   else
  #     session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
  #     redirect_to new_customer_registration_url, alert: @customer.errors.full_messages.join("\n")
  #   end
    
  # end

  

end
