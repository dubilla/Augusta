source 'https://rubygems.org'

ruby '2.7.8'

gem 'rails', '~> 6.0.6'
gem 'bootsnap', '~> 1.18' # 1.4.x breaks on Rails 6 activesupport autoload; 1.18+ still supports Ruby 2.7
# concurrent-ruby 1.3.5 dropped its implicit `require 'logger'`, which Rails 6.0's
# ActiveSupport relies on -> NameError at boot/asset-compile. Hold < 1.3.5 until the
# Ruby 3 / Rails 7.1 stage handles it natively. Fixes every entrypoint (incl. bin/webpack).
gem 'concurrent-ruby', '< 1.3.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '~> 1.5' # Rails 6 requires pg >= 1.1

gem 'sass-rails', '~> 6.0' # wraps sassc; drops EOL ruby-sass

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'
gem 'webpacker', '~> 5.x'

gem 'devise', '~> 4.8'
gem 'rake'
gem 'httparty'
gem 'dalli'
gem 'newrelic_rpm'
gem 'paper_trail', '~> 12.3'
gem 'pundit'
gem 'activeadmin', '~> 2.12.0' # last AA line supporting Rails 6.0 (2.13+ needs 6.1 → Stage 3); ransack < 4, formtastic, arbre
gem 'jsonapi-rails'
gem 'puma', '~> 5.6'
gem 'nokogiri', '~> 1.15.0' # 1.16+ requires Ruby >= 3.0; bump to ~> 1.16 at Stage 7

group :development do
  gem 'rubocop', require: false
  gem 'rails_best_practices', require: false
  gem 'guard-rspec', require: false
end

group :test, :development do
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-nav'
end

group :test do
  gem 'capybara'
  gem 'cuprite'
  gem 'factory_bot', '~> 5.2'
  gem 'factory_bot_rails', '~> 5.2'
  gem 'vcr'
  gem 'webmock'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
