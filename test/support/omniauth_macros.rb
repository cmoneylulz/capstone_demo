#require 'omniauth'

# Definitions for Omniauth Hash mocking
# @author Ashley Childress
# @version 3.15.2014
# @api public
module OmniauthMacros

	# Mock OmniAuth Hash with Google response
	def mock_google_hash
		OmniAuth.config.mock_auth[:google_oauth2] = { provider: 'google_oauth2',
		                                              uid: '12345',
		                                              info: {
				                                              name: 'Natasha Tester',
				                                              email: 'natashatester@email.com'
		                                              }
		}
	end

	# Mock OmniAuth Hash with Twitter response
	def mock_twitter_hash
		OmniAuth.config.mock_auth[:twitter] = { provider: 'twitter',
		                                        uid: '54321',
		                                        info: {
				                                        nickname: 'NatashaTheRobot',
				                                        first_name: 'Natasha',
				                                        last_name: 'RobotTester',
				                                        email: 'hi@natashatherobot.com'
		                                        },
		}
	end

	# Mock OmniAuth Hash with Facebook response
	def mock_facebook_hash
		OmniAuth.config.mock_auth[:facebook] = { provider: 'facebook',
		                                         uid: '456789',
		                                         info: {
				                                         name: 'Facebook Tester',
				                                         nickname: 'FacebookTester',
				                                         first_name: 'Facebook',
				                                         last_name: 'Tester',
				                                         email: 'facebooktester@email.com'
		                                         }
		}
	end

	# Mock OmniAuth Hash with invalid credentials
	def mock_invalid_hash
		OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
	end
end