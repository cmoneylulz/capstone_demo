# This +Ability+ class should be used to define permissions for all +Roles+ defined in this application.
# @author Ashley Childress
# @version 2.26.2014
class Ability
  include CanCan::Ability
  
  # Initialize the +current_user+ who is signed into this application and determine permissions for that user.
  # @note IMPORTANT The order of ability definitions *does matter*!
  def initialize(user)
  	user ||= User.new
  	
  	alias_action :show, :index, to: :read
  	alias_action :update, :edit, to: :modify
	  # @todo update manage alias
  	alias_action :index, :show, :read, :edit, :update, :delete, to: :manage

	  # Alias the +:crud+ action as +[:create, :show, :edit, :update, :delete]+
	  alias_action :create, :show, :edit, :update, :delete, to: :crud

	  # @todo UPDATE - this added for initial implementation
	  can [:read, :modify], Rating

  	# Any user can access information for their own profile
  	can :crud, [User], id: user.id

	  # No users (except Admin, below) can access the Users Home page
  	cannot :index, User

  	# Can view any Category or Comment
  	can [:read, :show], [Category, InterestPoint, Image, Comment, Artist]
  	cannot :read, InterestPoint, approver_id: nil
  	cannot :read, Image, approver_id: nil
  	cannot :read, Image, interest_point: { approver_id: nil }
  	
  	can :create, [Image, InterestPoint]
  	
  	if user.id.nil?
  		can :create, [User, Comment]
		  can :login, User
  		cannot :create, [InterestPoint]
		  cannot :modify, Rating
  		cannot [:modify, :create], [InterestPoint, Image] if { approver_id: nil }
	  else
			can :logout, User if { id: user.id}
  	end
  	
  	
  	## If the current user is a contributor
  	if user.is?('Contributor')
  		can :create, Comment
  		can :crud, Artist
  		# Then can view/modify any Interest Point or Image they created 
  		can [:crud], [InterestPoint, Image], contributor_id: user.id
  		can :upate_default_image, [InterestPoint, Image], contributor_id: user.id
			can :contributor_dashboard, [InterestPoint, Image]
  	end
  	
  	## If current user is admin
  	if user.is?('Administrator')
  		# then do everything
  		can :manage, :all
  		can [:create, :view_reported], Comment
  		can [:approve, :unapprove, :update_multiple, :approve_multiple, :unapprove_multiple, :update_default_image], InterestPoint
			can :admin_dashboard, [InterestPoint, Image]
  	end
  	
  	# Everyone can create an image
  	can :create, Image
  end
end
