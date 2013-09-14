source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
  gem 'handlebars_assets'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork'
  gem 'childprocess'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
end

group :linux do
  gem 'rb-inotify'
  gem 'libnotify'
end

group :macos do
  gem 'rb-fsevent', :require => false
  gem 'growl'
end

gem 'coveralls', require: false

gem 'jquery-rails'

gem 'websocket-rails'
gem 'thin'

gem 'delayed_job_active_record'

gem 'underscore'
gem 'backbone-rails'
gem 'backbone-relational-rails'
