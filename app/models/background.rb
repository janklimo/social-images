class Background < ActiveRecord::Base
  has_attached_file :image,
    path: 'backgrounds/:id/:basename.:hash.:extension',
    hash_secret: "JUST4URLUNIQUENESS",
    s3_protocol: "https",
    styles: { large: "1500x1500>", thumb: "300x300>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
