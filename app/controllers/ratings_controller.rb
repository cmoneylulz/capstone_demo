# Defines actions that may be taken for a +Rating+ model
# @author Chris Wilson < Ashley Childress
# @version 3.16.2014
# @api public
class RatingsController < ApplicationController

	# Set the appropriate +@rating+ before executing any controller action
	before_action :load_ratable, :set_valid_rating
	#before_action :set_valid_rating

	# Ensure the +current_user+ has access to the parent +Interest Point+
	authorize_resource :interest_point

	# Use +CanCan+ to fetch +@rating+ and authorize actions for the +current_user+
	authorize_resource :rating, through: :interest_point

	# Update the +Rating+ model which was previously defined by the +current_user+ for the parent +ratable+ object.
	# @pre +current_user => NOT nil?+
	# @post +self.score => params[:score]+
	# @example PUT /interest_point/1/rating/1?score=5
	# @api public
  def update
		p "UPDATE rating"
    if current_user.nil?
			flash.now[:error] = 'You must be signed in to specify a rating.'
    else
			@rating.ratable = @ratable
			@rating.user = current_user
	    if @rating.update_attributes(score: params[:score])
				respond_to do |format|
					format.js { render :nothing => true }
				end
	    else
				flash[:error] = "Something went wrong. Please try again."
	    end
    end
  end

	private

	# Defines valid parameters for a +Rating+ object
	# @api private
	def rating_params
		params.require(:rating).permit(:ratable, :score, :user)
	end

	# Sets the +@rating+ object currently used by this +RatingsController+
	# @post <tt>>@rating => Ratings.where(ratable: @ratable, user: current_user) ||
	#                     Rating.new(ratable: @ratable, user: current_user)</tt>
	def set_valid_rating
		@rating = Rating.where(ratable: @ratable, user: current_user).first
		@rating = Rating.create(ratable: @ratable, user: current_user) if @rating.nil?
	end

	# Load the +ratable+ parent object by parsing the requesting path
	# @return +@ratable => InterestPoint+
	# @api private
	def load_ratable
		resource, id = request.path.split('/')[1, 2]
		@ratable = resource.singularize.classify.constantize.find(id)
	end

end