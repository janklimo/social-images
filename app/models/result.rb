class Result < ActiveRecord::Base
  belongs_to :album

  has_attached_file :image,
    path: 'results/:id/:basename.:hash.:extension',
    hash_secret: "JUST4URLUNIQUENESS",
    s3_protocol: "https"
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
end
