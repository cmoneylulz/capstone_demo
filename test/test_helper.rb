ENV["RAILS_ENV"] = "test"

## Run simplecov to analyze coverage during testing
require 'simplecov'
SimpleCov.start 'rails' do
	## Ignore tests for the TextFormatHelper -> improperly reducing coverage value
	add_filter '/app/models/helpers/text_format_helper.rb'
end

require File.expand_path("../../config/environment", __FILE__)
require 'factories'

require 'rails/test_help'
require 'minitest/spec'

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
  #include FactoryGirl::Syntax::Methods
  include Authlogic::TestCase
  include OmniauthMacros
  include MailerMacros
end

OmniAuth.config.test_mode = true

## For mocks & method stubs
#require 'mocha/mini_test'