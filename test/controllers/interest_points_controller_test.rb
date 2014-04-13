require 'test_helper'

# its for +Interest Points Controller+
# @author Ashley Childress
# @version 2.25.2014
describe InterestPointsController do
	
	# Bypass user abilities that may prevent access to a page by always using the admin user
	before :all do
		@user = FactoryGirl.create(:user)
	  @ability = Ability.new(@user)
	  @controller.stubs(:current_ability).returns(@ability)
	  @controller.stubs(:current_user).returns(@user)
	end
	
	before :each do
		@ip = FactoryGirl.create(:interest_point)
	end

	it "must get index"	do
		@ability.can :read, InterestPoint
		get :index
		assert_response :success
		assert_not_nil assigns(:interest_points)
	end
	
	it "must get new" do
		@ability.can :create, InterestPoint
		get :new
		assert_response :success
	end	

	it "must create interest point" do
		skip "investigate failure"
		@ability.can :create, InterestPoint
		AdminMailer.expects(:deliver)
		mailer = mock('AdminMailer')
		mailer.expects(:new_pending_interest_point).returns(mailer)
		assert_difference('InterestPoint.count') do
			post :create, interest_point: FactoryGirl.attributes_for(:interest_point, category_id: 1, contributor_id: 1)
		end
		assert_redirected_to interest_point_path(assigns(:interest_point))
	end

	it "must set valid contributor for interest point" do
		skip "not yet implemented"
	end

	it "must show interest point" do
		@ability.can :read, InterestPoint
		get :show, id: @ip.id
		assert_response :success
	end
	
	it "must update interest point" do
		skip "investigate failure"
		@ability.can :edit, InterestPoint
		put :update, id: @ip.id, interest_point: { name: "Updated Interest Point" }
		assert_response :success
	end

	it "must delete interest point" do
		@ability.can :manage, InterestPoint
		assert_difference('InterestPoint.count', -1) do
			delete :destroy, id: @ip.id
		end
		assert_redirected_to interest_points_path
	end

end
