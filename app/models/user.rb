class User < ApplicationRecord
  rolify

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

  def assign_default_role
    self.add_role(:employee) if self.roles.blank? && self.created_by_invite?
    self.add_role(:vendor) if self.roles.blank?
  end

end
