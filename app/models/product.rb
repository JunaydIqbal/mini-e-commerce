class Product < ApplicationRecord

  belongs_to :company
  belongs_to :user

  # attr_accessor :name, :description, :price
  # def self.search(search)  
  #   where("lower(products.name) LIKE :search OR lower(companies.name) LIKE :search", search: "%#{search.downcase}%").uniq   
  # end

  # ThinkingSphinx::Index.define :product, :with => :active_record do
  #   indexes :name, :sortable => true
  #   indexes :description
  #   indexes :price
  #   #indexes [company.name], as: :company_name
  #   # has created_at, :type => :timestamp
  #   # has updated_at, :type => :timestamp
  # end

end
