require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module GroupDProject1
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default? to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # Turn off the default? locale warnings & do not enforce
    config.i18n.enforce_available_locales = false
    
    # Set minitest generator to generate fixtures and use specs for generated test classes
    config.generators do |g|
			g.test_framework :mini_test, spec: true, fixtures: false
		end
  end
end
