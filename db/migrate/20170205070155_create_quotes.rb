class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :category, null: false, default: 0
      t.text :text
      t.text :author

      t.timestamps null: false
    end
  end
end
