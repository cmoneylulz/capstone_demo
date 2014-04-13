require 'test_helper'

# Tests for +Comments Controller+
# @author Ashley Childress
# @version 2.25.2014
describe CommentsController do
  
  ## Stub abilities to prevent permission errors
  before do
		user = FactoryGirl.create(:user)
	  @ability = Ability.new(user)
	  @controller.stubs(:current_ability).returns(@ability)
	end
	
	before :each do
	  @interest_point = FactoryGirl.create(:interest_point)
  	@comment = FactoryGirl.create(:comment, commentable: @interest_point)
  end
  
  describe "when commentable is interest point" do
  	it "must get index" do
  		skip "Investigate 'name has already been taken' error"
			# @ability.can :read, Comment
	    # get :index, interest_point_id: @comment.commentable.id
	    # assert_response :success
	    # assert_not_nil assigns(:comments)
		end

		it "must create comment" do
			skip "investigate failure"
			@ability.can :create, @comment
			@controller.stubs(:load_commentable).returns(@comment.commentable)
	  	assert_difference('Comment.count') do
			 post :create, interest_point_id: @comment.commentable.id, comment: FactoryGirl.attributes_for(:comment, author: "Test Author")
	  	end
	  	assert_redirected_to interest_point_path(@comment.commentable)
		end

	  it "must delete comment" do
			@ability.can :delete, @comment
		  skip 'not yet implemented'
		end
  end
  
  describe "when commentable is category" do
  	it "is not yet implemented" do
		  skip
	  end
  end

end
