class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :company
  has_many :products
  has_many :invitees, class_name: "User", foreign_key: :invited_by_id
  # accepts_nested_attributes_for :company
  # attr_accessor :company
  #has_and_belongs_to_many :employees, class_name: "User", foreign_key: :user_id
  #belongs_to :company
  

  after_create :assign_default_role

  #before_create :create_new_company
  #after_create :create_and_associate_company


  def assign_default_role
    self.add_role(:employee) if self.roles.blank? && self.created_by_invite?
    self.add_role(:vendor) if self.roles.blank?
  end

  # def create_and_associate_company
  #   company = self.company.new
  #   # Other necessary attributes assignments

  #   company.save
  # end 

  # def create_new_company
  #   self.company << Company.new
  # end

  

  # def check_company?(comp)
  #   Company.include?(comp)
  #   # curr_user = User.find(u_id)
  #   # Company.include?(curr_user)
  # end


end
