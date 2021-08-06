class CreateCompanies < ActiveRecord::Migration[6.1]
  def up
    create_table :companies do |t|
      t.integer "user_id"
      t.string "name"
      t.string "description"
      t.boolean "visible", :default => true

      t.timestamps
    end
    add_index("companies", "user_id")
  end

  def down 
    drop_table :companies
  end
  
end
