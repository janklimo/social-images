class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
