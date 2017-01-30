class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|

      t.timestamps null: false
    end
  end
end
