class Company < ApplicationRecord

  belongs_to :user
  
  validates :name, presence: true, length: {maximum: 50}, allow_blank: false
  validates_uniqueness_of   :name 

  
end
