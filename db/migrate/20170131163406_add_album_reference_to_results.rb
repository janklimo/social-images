class AddAlbumReferenceToResults < ActiveRecord::Migration
  def change
    add_reference :results, :album, index: true, foreign_key: true
  end
end
