require 'test_helper'

# Tests for +Users Controller+
# @author Ashley Childress
# @version 2.25.2014
describe UsersController do
		
		# Bypass user abilities that may prevent access to a page by always using the admin user
		before :all do
    	user = FactoryGirl.create(:user)
    	@ability = Ability.new(user)
    	@controller.stubs(:current_ability).returns(@ability)
    	# First name called in navigation links, so this line prevents tests that would load those links from failing
    	#User.any_instance.stubs(:current_user).returns(user)
  	end
  	
  	before :each do
		  @user = FactoryGirl.create(:user)
  	end

  	it "must get index" do
  		@ability.can :manage, User
	    get :index
	    assert_response :success
	    assert_not_nil assigns(:users)
  	end

  	it "must get new" do
  		@ability.can :create, User
	    get :new
	    assert_response :success
  	end

  	it "must create user" do
		  skip "investigate failure"
  		@ability.can :create, User
		  assert_difference('User.count') do
				post :create, user: { user_name: 'aNewUser', password: 'Password1', password_confirmation: 'Password1', email: 'testemail@email.com', first_name: 'testuser', last_name: 'madeForTesting' }
		  end
		  response.must_equal :success
		  assert assigns(:user)
		  assert_redirected_to root_path
  	end

  	it "must show user" do
  		@ability.can :read, User
    	get :show, id: @user.id
    	assert_response :success
  	end

  	it "must get edit" do
  		@ability.can :edit, User
    	get :edit, id: @user.id
    	assert_response :success
  	end

  	it "must update user" do
  		@ability.can :edit, User
    	put :update, id: @user.id, user: { first_name: "Updated Name" }
		  assert_response :success
  	end

  	it "must destroy user" do
  		@ability.can :manage, User
  		assert_difference('User.count', -1) do
    		delete :destroy, id: @user.id
  		end
  		assert_redirected_to root_url
  	end
end
