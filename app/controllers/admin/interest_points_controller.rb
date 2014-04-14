# Defines methods for administrator functions related to +Interest Points+.
# @author Ashley Childress
# @version 3.6.2014
class Admin::InterestPointsController < ApplicationController
	
	# Use +CanCan+ to load +Interest Points+ for all methods, except the index action, according to the current user's security permissions.
	load_and_authorize_resource except: [:index, :update_default_image]
	
	# Load all +Interest Points+, regardless of status and ensure the current user has permission to manage those +Interest Points+.
	# @pre the +current user+ is an administrator
	# @post a list of all +Interest Points+ will be retrieved from the database and stored in this +Interest Points Controller+
	def index
		@interest_points = InterestPoint.all
		authorize! :manage, @interest_points
	end
	
	# This method stub is used to display the selected +Interest Point+ on the corresponding page.
	# @pre the +current user+ is an administrator
	# @post the +Interest Point+ identified by the given +id+ will be loaded for use by this +Interest Points Controller+
	# @param [Integer] id the number used to identify the specific +Interest Point+ to be displayed
	def show
		# Store this path for reference in admin/interest_points/set_defafult_image so users are redirected to this page after setting default
		store_location
	end
	
	# Approve the +Interest Point+, which is identified by the given +id+, by setting the +approver+ to the current user. A notification message will be displayed to the user which describes the result of executing this method.
	# @pre the +Interest Point+ must be pending
	# @post The +approver id+ for this +Interest Point+ will be equal to the current user's id and a subsequent call to +pending+ will be false.
	# @param [Integer] id the number used to identify the specific +Interest Point+ to be displayed
	def approve
		if @interest_point.update({approver_id: current_user.id, approved_at: DateTime.now})
			flash[:notice] = "This interest point is approved!"
		else
			flash[:error] = "Something went wrong! #{get_all_errors}"
		end
			redirect_to admin_interest_point_path(@interest_point)
	end
	
	# Remove the existing approval for this +Interest Point+ by removing the +approver+ information. A notification message will be displayed to the user which describes the result of executing this method.
	# @pre the +Interest Point+ must be active
	# @post all +approver+ information for this +Interest Point+ will be removed.
	# @param [Integer] id the number used to identify the specific +Interest Point+ to be displayed
	def unapprove
		if @interest_point.update({approver_id: nil, approved_at: nil})
			flash[:notice] = "The approval for this Interest Point has been revoked."
		else
			flash[:error] = "Something went wrong! #{get_all_errors}"
		end
		redirect_to admin_interest_point_path(@interest_point)
	end	
		
	# Execute the specified action, either +approve+ or +unapprove+, for selected +Interest Points+, which are identified in the array of +interest point ids+
	# @post +Interest Points+ identified by the set of +interest point ids+ will be updated according to the given +action+. A notification message will be displayed describing the result of executing this method.
	# @param [String] action +unapprove+ if all +Interest Points+ identified in the given array should be unapproved; or +approve+ if all should be approved by the +current user+
	# @param [Array] interest_point_ids the set of ids used to identify which +Interest Points+ should be approved or unapproved
	def update_multiple
		if params[:interest_point_ids].count < 1
			flash.now[:error] = "You must select at least one Interest Point"
			return
		end		
		message = unapprove_multiple if params[:unapprove]
		message = approve_multiple if params[:approve]
		redirect_to admin_interest_points_path, notice: message
	end
	
	# Set the +approver id+ and +approved at+ attributes for all given +Interest Points+
	# @post all +Interest Points+ identified in the given set of +interest point ids+ will be updated such that the +approver+ is set to the current user and the +approved at+ value is the current DateTime. A notification message will be returned.
	# @param [Array] interest_point_ids the set of ids used to identify which +Interest Points+ should be approved
	# @return [String] a notification message describing the result of executing this method 
	def approve_multiple
		if InterestPoint.find(params[:interest_point_ids]).update_all(approver_id: current_user.id, approved_at: DateTime.now)
			"The selected Interest Points have been approved."
		else
			"Something went wrong and the Interest Points could not be approved. Please try again."
		end
	end
	
	# Remove all +approver+ information the given +Interest Points+, which are identified by the list of +interest point ids+.
	# @post the +approver id+ and the +approved_at+ values are removed for all +Interest Points+ identified in the given set of +interest_point_ids+. A message will be returned that describes the result of executing this method as a String. 
	# @param [Array] interest_point_ids the set of ids used to identify which +Interest Points+ should be approved
	# @return [String] a notification message describing the result of executing this method 
	def unapprove_multiple
		if InterestPoint.where(id: params[:interest_point_ids]).update_all(approver_id: nil, approved_at: nil)
			"Approval has been revoked for the selected Interest Points."
		else 
			"Something went wrong and approval could not be revoked for these Interest Points. Please try again."
		end
	end
	
	# Updates the +default_image+ for the given +Interest Point+, which will be displayed to users throughout the application.
	# @post the +default_image+ for this +Interest Point+ will be set to the given +image_id+
	# @param [Integer] interest_point_id the +InterestPoint+ to set the default image for
	# @param [Integer] image_id the +image+ to set as default for the corresponding +Interest Point+
	def update_default_image
		@interest_point = InterestPoint.find(params[:interest_point_id])
  	authorize! :update_default_image, @interest_point
  	if @interest_point.update(default_image_id: params[:image_id])
	  	if @interest_point.default_image.pending.eql? true
				flash[:error]	= "The default image is pending, and will not be displayed in the application for users without permission to access pending Images. Consider changing the default image to an approved version, or approve the default image so it can be displayed."
			else					
  			flash[:notice] = "Default Image was successfully set!"
			end
  	else
  		flash[:error] = "Something went wrong and the default image for this Interest Point could not be set. Please try again."
  	end
  	
  	# store_location is called in the show method
  	redirect_back_or_to_default admin_interest_point_path(@interest_point)
	end
end
