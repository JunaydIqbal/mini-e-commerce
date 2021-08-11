class Product < ApplicationRecord

  belongs_to :company
  belongs_to :user

  def self.search(search)  
    where("lower(products.name) LIKE :search OR lower(companies.name) LIKE :search", search: "%#{search.downcase}%").uniq   
 end

end
