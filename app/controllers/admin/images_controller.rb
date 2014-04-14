# Defines administrator actions for an +Image+
# @api public
# @author Ashley Childress
# @version 3.5.2014
class Admin::ImagesController < ApplicationController
	
	# Use +CanCan+ to load +Images+ for all methods, except the index action, according to the current user's security permissions.
	load_and_authorize_resource except: :index
	
	# Loads a list of +Images+ and their +Interest Points+ to display on the page
	# @method GET
	# @example /admin/images#index
	# @api public
	def index
		@images = Image.pending
		#@images = InterestPoint.joins(:images).where(images: { approver_id: nil }).uniq.all
		@interest_points = InterestPoint.all
		# Store this path for reference in admin/images/set_defafult_image so users are redirected to this page after setting default
		store_location
	end
	
	
	# Approve the +Image+ identified by the given +id+, by setting the +approver+ to the current user;
	# A notification message will be displayed to the user which describes the result of executing this method
	# @pre the +Image+ must be pending
	# @post The +approver id+ for this +Image+ will be equal to the current user's id and a subsequent call to +pending+ will be false.
	# @param [Integer] id the number used to identify the specific +Image+ to be displayed
	# @example admin/interest_point/3/approve
	# @api public
	def approve
		if @image.update({approver_id: current_user.id, approved_at: DateTime.now})
			flash.now[:notice] = "This Image is approved!"
		else
			flash.now[:error] = "Something went wrong! #{get_all_errors}"
		end
		redirect_to admin_images_path
	end
	
	# Remove the existing approval for this +Image+ by removing the +approver+ information. A notification message will be displayed to the user which describes the result of executing this method.
	# @pre the +Image+ must be active
	# @post all +approver+ information for this +Image+ will be removed.
	# @param [Integer] id the number used to identify the specific +Image+ to be displayed
	# @example admin/interest_point/3/unapprove
	# @api public
	def unapprove
		if @image.update({approver_id: nil, approved_at: nil})
			flash.now[:notice] = "The approval for this Image has been revoked."
		else
			flash.now[:error] = "Something went wrong! #{get_all_errors}"
		end
		redirect_to admin_images_path
	end
	
	# Execute the specified action, either +approve+ or +unapprove+, for selected +Interest Points+, which are identified in the array of +interest point ids+
	# @post +Interest Points+ identified by the set of +interest point ids+ will be updated according to the given +action+. A notification message will be displayed describing the result of executing this method.
	# @param [String] action +unapprove+ if all +Interest Points+ identified in the given array should be unapproved; or +approve+ if all should be approved by the +current user+
	# @param [Array] interest_point_ids the set of ids used to identify which +Interest Points+ should be approved or unapproved
	# @example admin/images/update_multiple?image_ids=[1,2]&approve=true
	# @api public
	def update_multiple
		if params[:image_ids].count < 1
			flash.now[:error] = "You must select at least one Image"
			return
		end		
		message = unapprove_multiple if params[:unapprove]
		message = approve_multiple if params[:approve]
		redirect_to admin_images_path, notice: message
	end
	
	# Set the +approver id+ and +approved at+ attributes for all given +Interest Points+
	# @post all +Interest Points+ identified in the given set of +interest point ids+ will be updated such that the +approver+ is set to the current user and the +approved at+ value is the current DateTime. A notification message will be returned.
	# @param [Array] interest_point_ids the set of ids used to identify which +Interest Points+ should be approved
	# @return [String] a notification message describing the result of executing this method
	# @example admin/images/approve_multiple?image_ids=[1,2,3]
	# @api public 
	def approve_multiple
		if Image.where(id: params[:image_ids]).update_all(approver_id: current_user.id, approved_at: DateTime.now)
			"The selected Images have been approved."
		else
			"Something went wrong and the Images could not be approved. Please try again."
		end
	end
	
	# Remove all +approver+ information the given +Interest Points+, which are identified by the list of +interest point ids+.
	# @post the +approver id+ and the +approved_at+ values are removed for all +Interest Points+ identified in the given set of +interest_point_ids+. A message will be returned that describes the result of executing this method as a String. 
	# @param [Array] interest_point_ids the set of ids used to identify which +Interest Points+ should be approved
	# @return [String] a notification message describing the result of executing this method
	# @example admin/images/unapprove_multiple?image_ids=[1,2,3]
	# @api public 
	def unapprove_multiple
		if Image.where(id: params[:image_ids]).update_all(approver_id: nil, approved_at: nil)
			"Approval has been revoked for the selected Images."
		else 
			"Something went wrong and approval could not be revoked for these Images. Please try again."
		end
	end	
		
end