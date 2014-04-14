# This +Password Resets Controller+ should be used when sending a password reset token to a user who has forgotten his password.
# @author Ashley Childress
# @version 2.14.2014
class ResetPasswordsController < ApplicationController
	
	# Ensure that the +User+ for the given +perishable token+ is only generated when editing or updating the password
	before_filter :load_user_using_perishable_token, only: [:edit, :update]
	before_filter :find_user_by_email, only: :create
			
	# Create a new, empty Reset Passwords model that can be displayed on the corresponding +new+ page.
	def new
		@user = User.new
	end
	
	# Find the user associated with the given +email+ address and deliver password reset information to that email.
	# @param [String] email The email address that should be associated with a +User+ record in this application
	# @post If a +User+ is found with the given +email+ address, then an email will be sent to that address with instructions to reset the corresponding +Password+. Otherwise, an error is displayed that no +User+ could be found. 
	def create
		if params[:email].blank?
			flash.now[:error] = 'Email can\'t be blank'
			render 'new'
		end
		if @user.nil?
			UserMailer.missing_user(params[:email]).deliver!
		else
			@user.deliver_reset_password_instructions!
		end
		flash[:notice] = "Instructions to reset your password have been emailed to you."
		redirect_to root_path
	end
	
	# Render the default page
	def edit		
	end
	
	# Update the password for the +User+ with the corresponding +perishable token+
	def update
		@user.password = params[:password]
		@user.password_confirmation = params[:password_confirmation]
		if @user.save
			flash[:notice] = "Your password was successfully updated."
			redirect_to login_path
		else
			flash[:error] = get_all_errors
			render 'edit'
		end
	end
	
	private
	# Find the user with the given +perishable token+
	# @param [String] perishable_token The unique token generated for the +User+ when the password reset process was initiated.
	def load_user_using_perishable_token
		@user = User.find_using_perishable_token(params[:id])
		unless @user
			flash[:error] = "We apologize, but we couldn't locate your account.  " +
						"If you are having problems, try copying and pasting the URL from your email into your browser or try to reset your password again."
			redirect_to root_url
		end
	end
	
	# Defines accepted parameters for this +Reset Passwords Controller+.
	# @param (see #create)
	def reset_password_params
		params.fetch(:user, {}).permit(:password, :password_confirmation, :email)
	end
	
	# Set the current +User+ to the record with the given +email+ address
	def find_user_by_email
		@user = User.find_by_email(params[:email])
	end

	# Get a list of all errors preventing the +User+ from updating their +password+
	def get_all_errors
		@user.errors.full_messages.compact.join(', ')
	end
end
