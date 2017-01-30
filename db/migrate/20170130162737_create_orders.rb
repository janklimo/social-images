class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
