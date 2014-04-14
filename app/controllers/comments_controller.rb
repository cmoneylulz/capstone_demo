# Defines actions for a +Comment+ in this application, which may belong to an +InterestPoint+ or an +InterestType+ (future).
# @author	Ashley Childress
# @version 2.1.2014
class CommentsController < ApplicationController

	# Set the +@commentable+ for the +Comment+ object
	before_action :load_commentable
	  
  # Ensure the +current_user+ can access the parent +commentable+ record
  load_and_authorize_resource :interest_point, :category

  # Retrieve +@comment+ and authorize access for the +current_user+ for all actions except +reported+
  load_and_authorize_resource :comment, through: [:interest_point, :category], except: :reported

  # Gets a list of all Comments for the calling +commentable+ object.
  # @return All +Comment+ records that exist at the time this method is called.
  def index
  end

  # Create a new empty +Comment+.
  # @post If a +Comment+ had already been created, then this method will overwrite any data previously loaded.
  # @return An empty +Comment+ object that can be used when adding a new +Comment+ in this application.
  def new
  end
    
  # Add a new +Comment+ to the database with the user-specified +author+ and +body+. The user will be redirected to the calling object.
  # @pre A new empty +Comment+ should exist before this method is called.
  # @post A new +Comment+ will be added to the database with the given attributes. Calling +Comments.size?+ after this method has executed successfully will return one more than the number returned had the method been called before executing this method. If the +author+ or +body+ is not defined when this method executes, then an error message will be displayed.  
  # @param [String] author the name or alias of the person who wrote the comment
  # @param [String] body the comment text
  # @param [Commentable] commentable the object the comment is to be created for
  def create
  	@comment.commentable = @commentable
  	if @comment.save
  		flash[:notice] = "Thanks for the comment!"
  	else
  		flash[:error] = "Sorry! Monkeys just ate your comment. Please try again."
  	end
	  redirect_to @commentable
  end

	# Permanently delete the +Comment+ with the given +id+
	# @pre the given +id+ must match a valid +Comment+ record
	# @post the +Comment+ with the given +id+ will be removed
  def destroy
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to reported_comments_path
  end
  
  def reported
  	@comments = Comment.reported
  	authorize! :view_reported, @comments
  	render 'index'
  end
  
  private
  
  # Defines parameters that may be used to save a +comment+ in the database. 
  def comment_params
  	params.require(:comment).permit(:author, :body, :commentable)
  end
  
  # Load the commentable object for this CommentsController by parsing the requesting path.
  def load_commentable
  	resource, id = request.path.split('/')[1,2]
  	@commentable = resource.singularize.classify.constantize.find(id)
  end
  
end
