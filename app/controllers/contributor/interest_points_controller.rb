# This +Interest Points Controller+ should be used for all actions available to a contributor.
# @author Ashley Childress
# @version 3.6.2014
class Contributor::InterestPointsController < InterestPointsController
	
	load_and_authorize_resource only: [:edit]
	
  # Do not use +CanCan+ to load resources for this Controller; instead, resources are defined and manually authenticated in each method.
  skip_load_and_authorize_resource only: [:approve, :unapprove, :update_default_image]
  
  # Display a list of all +Interest Points+ created by the +current user+.
  # @pre the +current user+ must be a valid contributor
  # @post All +Interest Points+ created by the +current user+ will be loaded as a resource in this +Interest Points Controller+
	# def index
# 		
  # end
  
  def edit
  	
  end
  
  def update_default_image
  	@interest_point = InterestPoint.find_by(id: params[:interest_point_id])
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
  	render 'edit'
  end
  
  # Display a list of all +Interest Points+ created by the +current user+ and have not yet been approved.
  # @pre the +current user+ must be a valid contributor
  # @post All +Interest Points+ created by the +current user+ that are not yet approved will be loaded as a resource in this +Interest Points Controller+ and displayed to the user.
  def pending
  	@interest_points = InterestPoint.pending.where(contributor_id: current_user.id)
  	current_ability.can :read, @interest_points
  	render 'index'
  end
  
  # Display a list of all +Interest Points+ created by the +current user+ and have been approved by an application administrator.
  # @pre the +current user+ must be a valid contributor
  # @post All +Interest Points+ created by the +current user+ that are approved will be loaded as a resource in this +Interest Points Controller+ and displayed to the user.
  def active
  	@interest_points = InterestPoint.active.where(contributor_id: current_user.id)
  	current_ability.can :read, @interest_points
  	render 'index'
  end
  
end
