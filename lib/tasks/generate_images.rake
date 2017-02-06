require 'RMagick'
include Magick

task generate_images: :environment do
  dropbox_folder = "/Users/Admin/Dropbox/generated-images"
  name = ENV.fetch('NAME')
  # color = ENV.fetch('COLOR')

  destination_folder = "#{dropbox_folder}/#{Time.now.strftime("%Y%m%d")}_#{name}"
  Dir.mkdir(destination_folder) unless File.directory?(destination_folder)


  backgrounds = Dir[Rails.root.join('public/backgrounds/landscape/*')]
    .shuffle.take(99)
  quotes = Quote.order("RANDOM()").limit(backgrounds.size)

  backgrounds.each_with_index do |image_path, i|
    platforms.each do |platform|
      puts "Generating #{platform.to_s.titleize} image ##{i + 1}"

      width, height = dimensions_for(platform)

      image = Image.read(image_path).first
      logo = Image.read(Dir[Rails.root.join('public/logo.*')].first).first

      image.resize_to_fill!(width, height)
      logo.resize_to_fit!(width*0.2, height*0.09)

      quote = quotes[i]
      caption = Image.read("caption:#{quote.text.upcase}") do
        self.font = "#{Rails.root}/app/assets/fonts/futura.ttf"
        self.size = "#{width*0.45}x#{height*0.4}"
        # no pointsize will choose the biggest pointsize possible to fit
        self.gravity = CenterGravity
        self.background_color = 'transparent'
        self.fill = 'white'
      end.first

      caption_shadow = Image.read("caption:#{quote.text.upcase}") do
        self.font = "#{Rails.root}/app/assets/fonts/futura.ttf"
        self.size = "#{width*0.45}x#{height*0.4}"
        self.gravity = CenterGravity
        self.background_color = 'transparent'
        self.fill = 'black'
      end.first.gaussian_blur(0.0, 5.0)

      author = Image.read("caption:#{quote.author}") do
        self.font = "#{Rails.root}/app/assets/fonts/pacifico.ttf"
        self.size = "#{width*0.55}x"
        self.pointsize = 44
        self.gravity = CenterGravity
        self.background_color = 'transparent'
        self.fill = '#E1ECF4'
      end.first

      author_shadow = Image.read("caption:#{quote.author}") do
        self.font = "#{Rails.root}/app/assets/fonts/pacifico.ttf"
        self.size = "#{width*0.55}x"
        self.pointsize = 44
        self.gravity = CenterGravity
        self.background_color = 'transparent'
        self.fill = 'black'
      end.first.gaussian_blur(0.0, 4.0)

      vertical_offset_quote = -1 * (image.rows * 0.08)
      vertical_offset_author = (image.rows * 0.2)

      footer_for(image, logo).draw(image)
      image.composite!(caption_shadow, CenterGravity,
                       5, vertical_offset_quote + 2, OverCompositeOp)
      image.composite!(caption, CenterGravity, 0, vertical_offset_quote, OverCompositeOp)
      image.composite!(author_shadow, CenterGravity,
                       2, vertical_offset_author + 2, OverCompositeOp)
      image.composite!(author, CenterGravity, 0, vertical_offset_author, OverCompositeOp)
      image.composite!(logo, SouthEastGravity, 20, 10, OverCompositeOp)
      path = "#{destination_folder}/#{i + 1}_#{platform}.jpg"
      image.write(path)

      # cleanup
      caption.destroy!
      caption_shadow.destroy!
      author.destroy!
      author_shadow.destroy!
      image.destroy!
      logo.destroy!
    end
  end
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

def platforms
  facebook = ENV.fetch('FACEBOOK')
  twitter = ENV.fetch('TWITTER')
  [].tap do |platforms|
    platforms << :facebook if facebook
    platforms << :twitter if twitter
  end
end

def dimensions_for(platform)
  facebook_width = 1200
  facebook_height = 630
  twitter_width = 1024
  twitter_height = 512

  return facebook_width, facebook_height if platform == :facebook
  return twitter_width, twitter_height if platform == :twitter
end
