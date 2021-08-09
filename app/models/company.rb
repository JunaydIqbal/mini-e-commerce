class Company < ApplicationRecord

  belongs_to :user
  has_many :products
  #has_many :employees, through: :invitees
  
  #has_many :employees, through: :user, foreign_key: :invited_by_id, source: :users

  validates :name, presence: true, length: {maximum: 50}, allow_blank: false
  validates_uniqueness_of   :name 


  
  
end
