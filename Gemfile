source 'https://rubygems.org'

ruby "2.3.1"

gem 'rails', '4.2.7'
gem 'pg'
gem 'therubyracer', platforms: :ruby

gem 'sass-rails', '~> 5.0'
gem 'font-awesome-rails'
gem 'bootstrap', '~> 4.0.0.alpha5'
gem 'bourbon'
gem "administrate", "~> 0.3.0"

gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'haml', '~> 4.0.7'
gem 'rmagick'
gem 'devise'

group :development, :test do
  gem 'jazz_fingers'
end

group :test do
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'pry-rails'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'capybara', '~> 2.7.0'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-livereload'
end

group :production do
  gem 'rails_12factor'
end
