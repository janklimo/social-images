class AddAttachmentImageToResults < ActiveRecord::Migration
  def self.up
    change_table :results do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :results, :image
  end
end
