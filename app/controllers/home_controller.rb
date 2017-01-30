require 'RMagick'

class HomeController < ApplicationController
  include Magick

  def index
  end

  private

  def box_effect_image
    image = Image.read(Rails.root.join('app/assets/images/image.jpg')).first
    logo = Image.read(Rails.root.join('app/assets/images/hq.png')).first

    quote = "##{rand(10) + 1} A person who never made a mistake never tried anything new"
    caption = Image.read("caption:#{quote.upcase}") do
      self.size = "450x300"
      self.pointsize = 32
      self.font = "#{Rails.root}/app/assets/fonts/catamaran.ttf"
      self.gravity = CenterGravity
      self.background_color = '#0005'
      self.fill = 'white'
    end.first

    thumb = image
      .resize_to_fill(1200, 630)
      .composite(caption, CenterGravity, OverCompositeOp)
      .composite(logo.resize_to_fit(300, 300), SouthEastGravity, 20, 20, OverCompositeOp)
    thumb.write('thumb.jpg')
  end
end
