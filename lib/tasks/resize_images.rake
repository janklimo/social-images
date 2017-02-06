require 'RMagick'
include Magick

task resize_images: :environment do
  resize_folder = ENV.fetch('RESIZE_FOLDER')

  MAX_WIDTH = 1500

  Dir[Rails.root.join("public/#{resize_folder}/*")].each_with_index do |path, i|
    image = Image.read(path).first
    width = image.columns

    if width > MAX_WIDTH
      p "Resizing #{path}"
      image.resize_to_fit!(MAX_WIDTH)
      image.write(path)
    else
      p "No need to resize #{path}"
    end

    image.destroy!
  end
end
