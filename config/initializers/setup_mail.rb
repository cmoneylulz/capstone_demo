# Use Ashley's personal gmail account to send emails
ActionMailer::Base.smtp_settings = {
		address:		    	'smtp.gmail.com',
		port:			       	587,
		domain:			    	'gmail.com',
		user_name:		    	'anchildress1',
		password:		    	'ozqgibfchhzgmqye',
		authentication:		    'plain',
		enable_starttls_auto:   true
}

# Set default? host for url_for tag to localhost, which will be available in all mailers
ActionMailer::Base.default_url_options[:host] = "localhost:3000"