# Defines permissions for an +Image+.
# @see #InterestPointsController for actions related to an +Image+ object.
# @author Ashley Childress
# @version 3.14.2014
# @api public
class ImagesController < ApplicationController

	# Load the parent +Interest Point+ record and authorize access for the +current_user+
	load_and_authorize_resource :interest_point

	# Load this +Image+ record and authorize access for the +current_user+ through its parent +Interest Point+
	load_and_authorize_resource :image, through: :interest_point

	# @api public
	# Get a list of +images+ for the given +interest_point_id+
	# @param [Integer] interest_point_id the number identifying the +Interest Point+ for which all valid +Images+ should be returned
	# @return a list of all +Images+ associated with the given +interest_point_id+
	def index
	end

	# @api public
	# Create a new, empty +Image+ which should be associated with the given +interest_point_id+
	# @param [Integer] interest_point_id the number identifying the +Interest Point+ for which all valid +Images+ should be returned
	def new
	end

	# @api public
	# Creates an +Image+ record in the database with the given parameters
	# @pre the +file+ must be in png, jpg, jpeg, or gif format
	# @post the +file+ is saved in this application and can be retrieved using the saved +Image+ record
	# @param [String] file the pathname used to retrieve the +Image+ to be displayed on the page
	# @param [Integer] interest_point_id the number identifying the +Interest Point+ object this +Image+ is defined for
	# @param [Integer] contributor_id the number identifying the +User+ who created this +Image+
	# @param [Integer] approver_id the number identifying the +User+ who approved this +Image+
	# @param [DateTime] approved_at the date and time at which this +Image+ was last approved
	def create
		store_location
		if @image.save
			flash[:notice] = "Image was created successfully!"
			@image.notify_administrators!
			redirect_back_or_to_default interest_point_path(@image.interest_point)
		else
			flash[:error] = "Something went wrong and the image could not be saved: #{get_all_errors}"
		end
	end

	# @api public
	# Permanently delete the +Image+ record with the corresponding +id+ from this application
	# @pre +id+ must correspond to an existing +Image+ record
	# @post +Image.find(id) => nil+
	# @param [Integer] id the number used to uniquely identify the +Image+ record to delete
	def destroy
		store_location
		@interest_point = @image.interest_point
		@image.destroy
		flash[:notice] = 'Successfully removed Image'
		redirect_back_or_to_default @interest_point
	end

	private

	# @api private
	# @return [String] a list of all errors generated when attempting to save this +Image+ record
	def get_all_errors
		@image.errors.full_messages.compact.join(', ')
	end

	# @api private
	# Defines valid parameters available for an +Image+
	# @see #create
	def image_params
		params.require(:image).permit(:file, :interest_point_id, :contributor_id, :approver_id, :approved_at)
	end
end
