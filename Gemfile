source 'https://rubygems.org'
ruby '2.4.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.10'
# Pg is the Ruby interface to the PostgreSQL RDBMS
gem 'pg', '~> 0.21.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'slim-rails', '~> 3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# bootstrap-sass is a Sass-powered version of Bootstrap 3,
# ready to drop right into your Sass powered applications.
gem 'bootstrap-sass', '~> 3.3.6'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Flexible authentication solution for Rails with Warden.
gem 'devise', '~> 3.5'

# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator.
gem 'kaminari', '~> 0.16'

# AASM - State machines for Ruby classes
gem 'aasm', '~> 4.7'
# Trailblazer is a thin layer on top of Rails. It gently enforces
# encapsulation, an intuitive code structure and gives you an
# object-oriented architecture.
gem 'trailblazer', '~> 1.1'
gem 'trailblazer-rails', '~> 0.4'

# Classier solution for file uploads for Rails, Sinatra and other Ruby web frameworks
gem 'carrierwave', '~> 0.10'
# ActiveModel validations for file fields
gem 'file_validators', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


# TZInfo::Data contains data from the IANA Time Zone database packaged as Ruby modules for use with TZInfo.
gem 'tzinfo-data'

group :production do
  # Use Puma as the app server
  gem 'puma', '~> 2.15'
end

group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'better_errors', '~> 2.1'
  gem 'binding_of_caller'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Mutes assets pipeline log messages.
  gem 'quiet_assets'
end

group :test do
  # TDD, BDD and other D's
  gem 'rspec', '~> 3.7'
  gem 'rspec-rails', '~> 3.7'
  gem 'capybara', '~> 2.6'
  gem 'database_cleaner', '~> 1.5.1'
end

group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end