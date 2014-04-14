# This +Categories Controller+ should be used to interact with a grouping of similar +Interest Points+ defined in this application.
# @author Ashley Childress
# @version 2.20.2014
class CategoriesController < ApplicationController
		
	# Use default authorizations from CanCan gem
	load_and_authorize_resource	

  # Returns a list of all +Categories+ currently defined in this application.
  # @post A list of all +Categories+ will be displayed, along with controls to modify, delete, or create a new +Category+
  def index
  end

	# Displays details for the +Category+ that corresponds to the given +id+
	# @pre An +Category+ with the given +id+ currently exists in this application
	# @post Details for the corresponding +Category+ will be displayed
	# @param [Integer] id the unique identification number of the +Category+ to display details for
	def show
	end
	
	# Create a new, empty +Category+
	def new
	end

	# Create a new +Category+ with attributes equal to the given parameters.
	# @param [String] name the title used to identify the +Category+
	def create
		if @category.save
			flash[:notice] = "Category was created successfully!"
			redirect_to @category
		else
			flash[:error] = get_all_errors
			render 'new'
		end
	end

	# Permanently delete the +Category+ with the given +id+ from this application.
	# @param [Integer] id the unique identification number of the +Category+ that will be permanently removed from this application
	def destroy
		@category.destroy
		flash[:notice] = "Category was successfully removed."
		redirect_to categories_path
	end

	# Edit details for the +Category+ identified by the given +id+.
	# @param [Integer] id the unique identification number of the +Category+ to be modified
	def edit
	end

	# Modify details for the +Category+ identified by the given +id+. If one or more attributes are modified by the user, the corresponding database record will also be updated.
	# @param [Integer] id the unique identification number of the +Category+ to modify in the database using the specified attributes.
	# @param (see #create)
	def update
		if @category.update(category_params)
			flash[:notice] = "Successfully updated Category"
			redirect_to @category
		else
			flash[:error] = get_all_errors
			render 'edit'
		end
	end

	private

	# Define parameters that may be used when creating or modifying an +Category+.
	# @see (see #create)
	def category_params
		params.require(:category).permit(:name)
	end

	# Returns a list of all errors found when saving this +Category+.
	def get_all_errors
		@category.errors.full_messages.compact.join(',')
	end
end
