source 'https://rubygems.org'

ruby '3.3.11'

gem 'rails', '~> 7.1.5' # Stage 6: 7.0 → 7.1 (load_defaults 7.1)
gem 'bootsnap', '~> 1.18' # 1.4.x breaks on Rails 6 activesupport autoload
# (Stage 6) The concurrent-ruby < 1.3.5 pin is lifted at Rails 7.1 — 7.1's ActiveSupport
# requires 'logger' itself, so the old NameError at boot/asset-compile no longer applies.

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '~> 1.5' # Rails 6 requires pg >= 1.1

gem 'sass-rails', '~> 6.0' # wraps sassc; drops EOL ruby-sass

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

# terser replaces uglifier (ES5-only) for sprockets JS minification — ActiveAdmin 3.5
# ships ES6 (`const`) that uglifier can't parse. terser is the Rails 7 default.
gem 'terser', '~> 1.2'
# Stage 5a: webpacker → shakapacker (webpack 5, dart-sass). Drops @rails/webpacker 5
# (last thing pulling node-sass 4) → lets Heroku return to a supported Node (was pinned
# to Node 14 for node-sass/webpack-4). shakapacker 8 runs on Rails 6.1+ and Node 14–22.
# Pinned exact and kept in lockstep with the npm `shakapacker` (see package.json)
# — shakapacker.yml `ensure_consistent_versioning` fails the build if they drift.
gem 'shakapacker', '8.4.0'

gem 'devise', '~> 4.8'
gem 'rake'
gem 'httparty'
gem 'newrelic_rpm'
gem 'paper_trail', '~> 15.1' # Stage 6: 12.3 → 15.x for Rails 7.1
gem 'pundit'
# Stage 5b: AA 2.14 → 3.x (latest stable 3-line; railties >= 6.1, so it spans this
# Rails 6.1 stage and the 7.0 bump in 5c). AA 3 requires Ransack 4 (pinned below).
gem 'activeadmin', '~> 3.5'
# Ransack 4 requires every AA-exposed model to allowlist searchable attrs/assocs via
# ransackable_attributes/ransackable_associations (see app/models/*), else index pages
# raise at query time. Declared explicitly (floor ~> 4.1) since it's the
# security-sensitive item; the float lets 5c pick up any 4.x fixes on Rails 7.
gem 'ransack', '~> 4.1'
gem 'jsonapi-rails'
gem 'puma', '~> 6.4' # Stage 6: 5.6 → 6.x for Rails 7.1
gem 'nokogiri', '~> 1.16' # Stage 7: 1.15.x has no Ruby 3.3 build; 1.16+ required

group :development do
  gem 'rubocop', require: false
  gem 'rails_best_practices', require: false
  gem 'guard-rspec', require: false
  # listen 3.1.5 (transitive via guard/railties) pulls ruby_dep, which caps at Ruby ~> 2.2
  # and blocks resolution on Ruby 3.1. listen dropped ruby_dep in 3.2; pin a modern line.
  gem 'listen', '~> 3.8'
end

group :test, :development do
  gem 'rspec-rails', '~> 6.1' # 4.x caps at Rails 6.1; 6.x supports Rails 6.1–7.1 (Stage 5c)
  # Stage 7: pry 0.12 breaks on Ruby 3.3 (uses the removed Object#=~). Bumped to 0.14; the
  # abandoned pry-remote (2013) / pry-nav (2019) were dropped — pry-byebug is the modern
  # step-debugging replacement if wanted.
  gem 'pry', '~> 0.14'
end

group :test do
  gem 'capybara'
  gem 'cuprite'
  gem 'factory_bot', '~> 5.2'
  gem 'factory_bot_rails', '~> 5.2'
  gem 'vcr', '~> 5.1'
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
