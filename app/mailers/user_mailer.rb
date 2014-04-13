# This +User Notifier+ should be used to generate and send an email to a +User+ to notify them of changes made to their account.
# @author Ashley Childress
# @version 2.16.2014 > 3.9.2014
class UserMailer < ActionMailer::Base
	
	# Set the default email address displayed as the 'From' address in all emails.
	default from: "webmaster@interestpoint.com"
  	
	# Create a new email and send it to the +email+ associated with the given +User+ record with a +perishable token+ that can be used to reset their +password+.
	# @pre The given +user+ should match a valid user record in this application.
	# @post An email will be generated for the +email+ address defined for the corresponding +User+ record, along with reset instructions and a unique, perishable reset token.
	# @param [User] user The +User+ object for whom a password reset email should be sent.
	def reset_password_instructions(user)
		@edit_reset_password_url = edit_reset_password_url(user.perishable_token)
		mail(to: user.email.to_s, subject: "Password reset instructions")
	end
	
	# Create a new email and send it to the given +email+ address that specifies no user has been created with that email in this application.
	# @pre The given +email+ must not exist in any +User+ record in this application
	# @post A generic email will be generated and address to the +email+ address given, along with a message that notifies the user that no +user+ record exists in this application.
	# @param [String] email The email address that this message should be addres to
	def missing_user(email)
		mail(to: email.to_s, subject: "Password reset request")
	end
	
	# Create a new email and send it to the +email+ address associated with the given +user+ record.
	# @pre The gen +user+ should match a valid user record in this application
	# @post A welcome email will be generated and sent to the +email+ address defined for the corresponding +User+ record.
	# @param [User] The +User+ object for whom a welcome email should be sent
	def welcome_email(user)
		@user = user
		mail(to: user.email.to_s, subject: "Welcome to Interest Points")	
	end
end
