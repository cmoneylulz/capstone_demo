ENV["RAILS_ENV"] = "test"

## Run simplecov to analyze coverage during testing
require 'simplecov'
SimpleCov.start 'rails' do
	## Ignore tests for the TextFormatHelper -> improperly reducing coverage value
	add_filter '/app/models/helpers/text_format_helper.rb'
end

require File.expand_path("../../config/environment", __FILE__)
require 'rails/test_help'
require 'minitest/spec'
require 'capybara/rails'
require 'factory_girl_rails'
require 'authlogic/test_case'

require 'support/omniauth_macros'
require 'support/mailer_macros'

## Format test output & add pretty colors
Turn.config do |c|
 c.format  = :outline
 c.trace   = false
 c.verbose = false
 c.natural = true
end

# Configure the test suite that can be called with '$rake minitest'
class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
  include Authlogic::TestCase
  include OmniauthMacros
  include MailerMacros

  DatabaseCleaner.strategy = :transaction
  DatabaseCleaner.clean_with(:truncation)

  ## Ensure validity of all Factories before running any tests
  before :suite do
  	begin
  		DatabaseCleaner.start
  		FactoryGirl.lint
  	ensure
  		DatabaseCleaner.clean
  	end
  end
  
	before :each do
		DatabaseCleaner.start
	end
	
	after :each do
		# Clear the database
		DatabaseCleaner.clean
	end
	
	after :suite do
	   if Rails.env.test? #|| Rails.env.cucumber?
      tmp = FactoryGirl.create(:image)
      store_path = File.dirname(File.dirname(tmp.file_url))
      temp_path = tmp.file.cache_dir
      FileUtils.rmdir(Dir["#{Rails.root}/test/support/#{store_path}/[^.]*"])
      FileUtils.rmdir(Dir["#{temp_path}/[^.]*"])
			 ## @todo test FileUtils.rmdir
    end
	end
end

# Configure Integration testing for MiniTest Spec DSL
class IntegrationTest < MiniTest::Spec
	include Rails.application.routes.url_helpers
	include Capybara::DSL

	register_spec_type(/Integration$/, self)

	after :each do
		Capybara.reset_sessions!    # Forget the (simulated) browser state
		Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
		reset_emails
	end
end

OmniAuth.config.test_mode = true

## For mocks & method stubs
require 'mocha/mini_test'