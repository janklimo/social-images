require 'RMagick'
include Magick

task generate_images: :environment do
  dropbox_folder = "/Users/Admin/Dropbox/generated-images"
  name = ENV.fetch('NAME')
  color = ENV.fetch('COLOR')

  FACEBOOK_WIDTH = 1200
  FACEBOOK_HEIGHT = 630

  destination_folder = "#{dropbox_folder}/#{Time.now.strftime("%Y%m%d")}_#{name}"
  Dir.mkdir(destination_folder) unless File.directory?(destination_folder)

  logo = Image.read(Dir[Rails.root.join('public/logo.*')].first).first

  backgrounds = Dir[Rails.root.join('public/backgrounds/landscape/*')].shuffle
  quotes = Quote.order("RANDOM()").limit(backgrounds.size)

  backgrounds.each_with_index do |image, i|
    puts "Generating Facebook image ##{i + 1}"

    image = Image.read(image).first

    image.resize_to_fill!(FACEBOOK_WIDTH, FACEBOOK_HEIGHT)
    logo.resize_to_fit!(FACEBOOK_WIDTH*0.2, FACEBOOK_HEIGHT*0.09)

    quote = quotes[i]
    caption = Image.read("caption:#{quote.text.upcase}") do
      self.font = "#{Rails.root}/app/assets/fonts/futura.ttf"
      self.size = "#{FACEBOOK_WIDTH*0.45}x#{FACEBOOK_HEIGHT*0.4}"
      # no pointsize will choose the biggest pointsize possible to fit
      self.gravity = CenterGravity
      self.background_color = 'transparent'
      self.fill = 'white'
    end.first

    caption_shadow = Image.read("caption:#{quote.text.upcase}") do
      self.font = "#{Rails.root}/app/assets/fonts/futura.ttf"
      self.size = "#{FACEBOOK_WIDTH*0.45}x#{FACEBOOK_HEIGHT*0.4}"
      self.gravity = CenterGravity
      self.background_color = 'transparent'
      self.fill = 'black'
    end.first.gaussian_blur(0.0, 5.0)

    author = Image.read("caption:#{quote.author}") do
      self.font = "#{Rails.root}/app/assets/fonts/pacifico.ttf"
      self.size = "#{FACEBOOK_WIDTH*0.35}x"
      self.pointsize = 44
      self.gravity = CenterGravity
      self.background_color = 'transparent'
      self.fill = '#E1ECF4'
    end.first

    author_shadow = Image.read("caption:#{quote.author}") do
      self.font = "#{Rails.root}/app/assets/fonts/pacifico.ttf"
      self.size = "#{FACEBOOK_WIDTH*0.35}x"
      self.pointsize = 44
      self.gravity = CenterGravity
      self.background_color = 'transparent'
      self.fill = 'black'
    end.first.gaussian_blur(0.0, 4.0)

    vertical_offset_quote = -50
    vertical_offset_author = 120
    # backdrop_for(caption, image).draw(image)
    footer_for(image, logo).draw(image)
    image.composite!(caption_shadow, CenterGravity,
                     5, vertical_offset_quote + 2, OverCompositeOp)
    image.composite!(caption, CenterGravity, 0, vertical_offset_quote, OverCompositeOp)
    image.composite!(author_shadow, CenterGravity,
                     2, vertical_offset_author + 2, OverCompositeOp)
    image.composite!(author, CenterGravity, 0, vertical_offset_author, OverCompositeOp)
    image.composite!(logo, SouthEastGravity, 20, 10, OverCompositeOp)
    path = "#{destination_folder}/#{i + 1}_facebook.jpg"
    image.write(path)

    # cleanup
    caption.destroy!
    caption_shadow.destroy!
    author.destroy!
    author_shadow.destroy!
    image.destroy!
  end

  logo.destroy!
end

def footer_for(image, logo)
  x0 = 0
  y0 = image.rows - (logo.rows + 20)
  x1 = image.columns
  y1 = image.rows

  backdrop = Draw.new
  backdrop.fill('#FFF')
  backdrop.fill_opacity(0.35)
  backdrop.rectangle(x0, y0, x1, y1)
end

def backdrop_for(caption, image)
  padding_x = 20
  padding_y = 20

  x0 = image.columns/2 - caption.columns/2 - padding_x
  y0 = image.rows/2 - caption.rows/2 - padding_y
  x1 = image.columns/2 + caption.columns/2 + padding_x
  y1 = image.rows/2 + caption.rows/2 + padding_y

  backdrop = Draw.new
  backdrop.fill('#FFF')
  backdrop.fill_opacity(0.2)
  backdrop.rectangle(x0, y0, x1, y1)
end
