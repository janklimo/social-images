class AddTokenToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :token, :string
    add_index :orders, :token, unique: true
  end
end