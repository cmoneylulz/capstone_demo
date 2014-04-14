# Defines helper methods for application mailers to use during integration testing
# @author Ashley Childress
# @version 3.15.2014
# @api public
module MailerMacros

	# Get the last email sent by any +ActionMailer+ in this application
	def last_email
		ActionMailer::Base.deliveries.last
	end

	# Clear all emails sent by any +ActionMailer
	def reset_emails
		ActionMailer::Base.deliveries = []
	end
end