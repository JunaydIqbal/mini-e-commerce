ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes :name, :sortable => true
  indexes :description
  indexes :price
  #indexes [company.name], as: :company_name
  # has created_at, :type => :timestamp
  # has updated_at, :type => :timestamp
end