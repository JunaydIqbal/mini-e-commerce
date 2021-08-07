class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :company
  has_many :invitees, class_name: "User", foreign_key: :invited_by_id
  
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:employee) if self.roles.blank? && self.created_by_invite?
    self.add_role(:newuser) if self.roles.blank?
  end

end
