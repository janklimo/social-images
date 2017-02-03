require 'RMagick'
include Magick

task generate_images: :environment do
  dropbox_folder = "/Users/Admin/Dropbox/generated-images"
  name = ENV.fetch('NAME')

  FACEBOOK_WIDTH = 1200
  FACEBOOK_HEIGHT = 630

  destination_folder = "#{dropbox_folder}/#{Time.now.strftime("%Y%m%d")}_#{name}"
  Dir.mkdir(destination_folder) unless File.directory?(destination_folder)

  1.times do |i|
    puts "Generating Facebook image ##{i + 1}"

    image = Image.read(Rails.root.join('app/assets/images/image.jpg')).first
    logo = Image.read(Rails.root.join('app/assets/images/hq.png')).first

    quote = "##{rand(10) + 1} A person who never made a mistake never tried anything new"
    caption = Image.read("caption:#{quote.upcase}") do
      self.size = "#{FACEBOOK_WIDTH*0.45}x"
      self.pointsize = 36
      self.font = "#{Rails.root}/app/assets/fonts/catamaran.ttf"
      self.gravity = CenterGravity
      self.background_color = 'transparent'
      self.fill = 'white'
    end.first

    image.resize_to_fill!(FACEBOOK_WIDTH, FACEBOOK_HEIGHT)
    backdrop_for(caption, image).draw(image)
    image.composite!(caption, CenterGravity, OverCompositeOp)
    image.composite!(logo.resize_to_fit!(300, 300), SouthEastGravity, 20, 20, OverCompositeOp)

    path = "#{destination_folder}/#{i + 1}_facebook.jpg"
    image.write(path)

    # cleanup
    caption.destroy!
    image.destroy!
    logo.destroy!
  end
end

def backdrop_for(caption, image)
  padding_x = 20
  padding_y = 20

  x0 = image.columns/2 - caption.columns/2 - padding_x
  y0 = image.rows/2 - caption.rows/2 - padding_y
  x1 = image.columns/2 + caption.columns/2 + padding_x
  y1 = image.rows/2 + caption.rows/2 + padding_y

  backdrop = Draw.new
  backdrop.fill('#000')
  backdrop.fill_opacity(0.5)
  backdrop.rectangle(x0, y0, x1, y1)
end
