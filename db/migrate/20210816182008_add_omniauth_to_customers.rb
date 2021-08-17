class AddOmniauthToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :provider, :string
    add_column :customers, :cid, :string
  end
end
