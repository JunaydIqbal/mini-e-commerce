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

  def to_builder
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity 1
    end
  end

  # after_create do
  #   product = Stripe::Product.create(name: name)
  #   price = Stripe::Price.create(product: product, unit_amount: (self.price * 100).to_i, currency: "usd")
  #   update(stripe_product_id: product.id, stripe_price_id: price.id)
  # end

  def to_s
    name
  end

  after_create do
    product = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: product, unit_amount: (self.price * 100).to_i, currency: "usd")
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end

end
