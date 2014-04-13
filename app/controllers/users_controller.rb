# This controller is responsible for all actions related to application Users, including creation of new users, editing existing users, and removing users.
# @author Ashley Childress
# @version 2.7.2014
class UsersController < ApplicationController
			
	# Use default authorizations from CanCan gem for all actions except +index+, which is defined manually
	load_and_authorize_resource
	
	# Create a new, empty +User+.
	def new
	end
	
	# Create a new +User+ that can log into this application.
	# @pre The given +user_name+ is a unique record and the +first_name+, +last_name+, +password+, and +email+ are defined.
	# @post A new +User+ with the specified +user_name+, +first_name+, +last_name+, +password+, and +email+ is added to the database.
	# @param [String] user_name the unique name used to identify the corresponding user in this system
	# @param [String] first_name the first name of the person for whom this +User+ is being created for
	# @param [String] last_name the last name of the person for whom this +User+ is being created for
	# @param [String] password the secret text that will be used to authenticate the corresponding +User+ in this system
	# @param [String] password_confirmation a duplicate entry of the given password used to confirm that no erraneous characters were entered in the +password+
	# @param [String] email the address used by this system in the event that the +User+ cannot remember her password
	# @param [Role] the +Role+ object that should be associated with this +User+
	def create
		if @user.save
			flash[:notice] = "Your account has been successfully created!"
			UserMailer.welcome_email(@user).deliver!
			redirect_to root_url
		else
			flash[:error] = get_all_errors
			render 'new'
		end
	end
		
	# Set the +User+ record for this +Users Controller+ to the record identified by the given id
	def show
	end
	
	# Display a list of all application Users defined in this system
	# @post this +Users Controller+ will contain a list of all +User+ objects that exist in this application
	def index
	end
	
	# Permanently delete the +User+ record with the given +id+ and display the users/index page. If the record was successfully deleted, then a success message should be displayed; otherwise, an error message will inform the user that the corresponding +User+ could not be deleted.
	# @pre a valid +User+ must be set in this +Users Controller+
	# @post the +User+ record currently set in this +Users Controller+ will be deleted
	def destroy
		if @user == current_user
			session[:user_id] = nil
			@current_ability = nil 
		end
		@user.destroy
		flash[:notice] = "User was successfully deleted."
		redirect_to root_url
	end
		
	# Modify details for the +User+ currently set in this +Users Controller+
	# @pre a valid +User+ must be set in this +Users Controller+
	# @post The +User+ object used by this +Users Controller+ will be updated with the specified parameters 
	# @see create for a list of acceptable parameters
	def edit
	end
	
	# Modify details for the +User+ currently set in this +Users Controller+
	# @pre a valid +User+ must be set in this +Users Controller+
	# @post attributes for the +User+ will be updated according to the specified parameters
	# @see create for a list of acceptable parameters
	def update
		if @user.update(user_params)
			flash[:notice] = "User account was updated successfully."
			redirect_to user_path(@user)
		else
			flash[:error] = get_all_errors
			render 'edit'
		end		
	end
	
	private	
	# Defines the set of parameters that should be included in the call to create a new +User+.
	# @see (see #create)
	def user_params
		params.require(:user).permit(:user_name, :first_name, :last_name, :password, :password_confirmation, :email, :role_id)
	end
		
	# Returns a comma-separated list of all errors found during the last attempt to create or update this +User+, as a String.
	def get_all_errors
		@user.errors.full_messages.compact.join(',')
	end
end