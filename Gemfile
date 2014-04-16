source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use rambling-slider image carousel
gem 'rambling-slider-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  gem 'yard'
  gem 'guard-yard'
  gem 'yardstick'
  gem 'yard-activerecord'
  gem 'guard-annotate'
  gem 'annotate'
end

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Use automated testing via guard; additional plugins for annotations & documentation
gem 'guard'

# If applicable, do not poll for changes when using guard
require 'rbconfig'
gem 'wdm', '>= 0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw|cygwin/i

# Require minitest & helpers for testing
group :development, :test do
 	gem 'minitest-rails'
  gem 'minitest-reporters' # for RubyMine integration
 	gem 'minitest-spec-rails'
  gem 'capybara_minitest_spec' # execute integration tests
 	
	# For testing, use factories instead of fixtures and use database_cleaner to speed up testing
	gem 'factory_girl_rails'
	gem 'database_cleaner'
	
	gem 'guard-minitest'
	#gem 'guard-livereload'
	#gem 'spring'
end

group :test do
	gem 'turn'	# Display test output in pretty colors
	gem 'faker' # Generate random data
	gem 'simplecov', '~> 0.7.1', require: false
	gem 'minitest-spec-context'
	gem "launchy"
end

# Mocks and stubs for testing
gem 'mocha', :require => false

# Provides simple page authorization
gem 'cancancan', '~> 1.7'

# Require authlogic for passwords - omniauth provides support to login with facebook, google+, and twitter support
gem 'authlogic'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"

# Use Geocoder to help with address and coordinate information --> [AC] Suggestion, but not yet installed
gem 'geocoder'
# Use Google Maps For Rails for map display
gem 'gmaps4rails'

# Use Carrierwave for image uploads and display
gem 'carrierwave'

#twitter bootstrap
gem 'bootstrap-sass'
gem 'bootstrap_form'
group :development do
  gem 'rails_layout'
	
	# Display better errors and allow troubleshooting directly in browser if errors are caught in the code
  gem 'better_errors'
  gem 'binding_of_caller' 
  gem 'debugger'  
end

## Code analyzers
gem 'flog'
gem 'reek'

gem 'sqlite3', :group => [:development, :test]
group :production do
  gem 'pg'
  gem 'thin'
end

gem 'scrypt'
gem 'rails_12factor'