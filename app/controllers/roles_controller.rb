# This +Roles Controller+ should be used for all actions related to a specific +Role+, such as creating a new +Role+. Use the +Users Controller+ to assign a +Role+ to a specific +User+.
# @author Ashley Childress
# @version 2.24.2014
class RolesController < ApplicationController
	
		# Use default authorizations from CanCan gem
		load_and_authorize_resource	
	
  	# Get a list of all +Roles+
  	def index
    		#@roles = Role.all
  	end

  	# Get the +Role+ identified by the given +role_id+
  	# @pre a valid +Role+ record must exist for the given +role_id+
  	# @post The +Role+ currently set in this +Roles Controller+ will be the object with the given +role_id+.
  	# @param [Integer] role_id the unique number used to identify a specific +Role+ record in this application
  	def show
			#@role = Role.find(params[:id])
  	end

  	# Create a new, empty +Role+ object
  	def new
    	#@role = Role.new
  	end

  	# Get the specific +Role+ that should be modified by this +Role Controller+
  	# @pre a valid +Role+ record must exist for the given +role_id+
  	# @post The +Role+ currently set in this +Roles Controller+ will be the object with the given +role_id+.
  	# @param [Integer] role_id the unique number used to identify a specific +Role+ record in this application
  	def edit
			#@role = Role.find(params[:id])
  	end

  	# Create a new +Role+ record with the given +name+
  	# @pre the +name+ must be valid for this +Role+
  	# @post a new +Role+ record will be added to the database with the same +name+ given with an +id+ one greater than the last id used by any +Role+ record
  	# @param [String] name the name that will be used to identify the new +Role+ 
  	def create
    	#@role = Role.new(role_params)
	    if @role.save
	      flash[:notice] = "The Role was successfully created."
	 			redirect_to @role        
	 		else
	 			flash[:error] = "Something went wrong creating the role. #{get_all_errors}"
	   		render action: 'new'
      	end
  	end

 	# The +Role+ currently used by this +Roles Controller+ will be updated to the given +name+
 	# @pre a valid +Role+ object must currently be set in this +Roles Controller+
 	# @post the set +Role+ object will be updated to have the given +name+
 	# @param [String] name the new +name+ that will be used to identify this +Role+ 
  	def update
			#@role = Role.find(params[:id])
    	if @role.update(role_params)
        flash[:notice] = 'Role was successfully updated.'
        redirect_to @role
 			else
   			render action: 'edit' 
      end
  	end

  	# Permanently remove the +Role+ object currently set in this +Roles Controller+
  	# @pre a valid +Role+ object must be set in this +Roles Controller+
  	# @post the +Role+ object set will be removed from the application
  	def destroy
			#@role = Role.find(params[:id])
			@role.destroy
			flash[:notice] = "Role was successfully deleted."
			redirect_to roles_url
  	end

		## Private methods
  	private
  
  	# @return A list of all error messages generated for this +Role+
  	def get_all_errors
  		@role.errors.full_messages.compact.join(", ")
  	end
  	
    # Set the +Role+ object currently used by this +Roles Controller+ to the object with the given +id+
    # @pre a valid +Role+ record must exist with the given +id+
    # @post the +Role+ currently used by this +Roles Controller+ will be set to the +Role+ with the given +id+
    # @param [Integer] id the unique identification number for the +Role+ to be set
    # def set_role
      # @role = Role.find(params[:id])
    # end

    # Defines the list of parameters that may be associated with a +Role+ object
    def role_params
      params.require(:role).permit(:name)
    end
end
