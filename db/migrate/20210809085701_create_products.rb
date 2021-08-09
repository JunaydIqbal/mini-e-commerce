class CreateProducts < ActiveRecord::Migration[6.1]
  
  def up
    create_table :products do |t|
      t.integer :company_id
      t.integer :user_id
      t.string :name
      t.text :description
      t.decimal :price

      t.timestamps
    end
    add_index("products", "company_id")
    add_index("products", "user_id")
  end

  def down
    drop_table :products
  end

end
