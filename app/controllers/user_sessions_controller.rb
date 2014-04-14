# This +User Sessions Controller+ should be used to get the current logged in +User+ throughout this application
# @api public
# @author Ashley Childress
# @version 2.14.2014
class UserSessionsController < ApplicationController
	
	before_filter :reset_current_ability
	
	# Load the +User Session+ and authorize all controller actions
	load_and_authorize_resource class: User, parent: false
		
	# Create a new empty +User Session+
	def new
		# @user automatically set by +CanCan+
	end
	
	# Start a new +User Session+ for the given +User+
	# @post If using social media and the +User+ is not found, then one will be created
	# @method CREATE
	# @return [User, UserSession] if an existing +User+ is found, then a new +UserSession+ is created
	def create
		## Check if the +User+ attempted to sign in with social media and use the appropriate method to create the +User Session+
		if env["omniauth.auth"]
			user = User.from_omniauth(env["omniauth.auth"])
			if user.valid?
				session[:user_id] = user.id 
			end
		else
			user = User.find_by(user_name: params[:user][:user_name])
			if user && user.valid_password?(params[:user][:password])
				session[:user_id] = user.id
			end
		end

		## Ensure the +User Session+ is saved and display the appropriate page
		if current_user
			flash[:notice] = 'Login successful!'
			redirect_back_or_to_default(root_url)
		else
			flash[:error] = 'Sorry, we are unable to locate that account. Please try again!'
			session[:user_id] = nil
			render 'new'
		end
	end
	
	# End the current +User Session+ and log out the corresponding +User+
	# @pre a valid +User Session+ exists for this application
	# @post the existing +User Session+ is deleted in this application and the +current_ability+ is nil
	# @method DELETE
  def destroy
		session[:user_id] = nil
		flash[:notice] = 'Logout successful!'
		redirect_to root_url
	end
	
	private

	# @api private
	# Define acceptable attributes for +user_name+ and +password+ that can be used to create a new +User Session+
	def user_session_params
		params.fetch(:user, {}).permit(:user_name, :password)
	end
	
	# @api private
	# @post +@current_ability+ => +:nil+
	def reset_current_ability
		@current_ability = nil
	end
	
end
