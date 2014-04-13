require "test_helper"

describe Admin::InterestPointsController do
  # Bypass user abilities that may prevent access to a page by always using the admin user
	before :all do
		@user = FactoryGirl.create(:user)
	  @ability = Ability.new(@user)
	  @controller.stubs(:current_ability).returns(@ability)
	end
	
	before :each do
		@interest_point = FactoryGirl.create(:interest_point)
	end
	
	it "must get index" do
		@ability.can :view, @interest_point
		get :index, scope: :admin
		assert_response :success
		assigns(:interest_points).wont_be_nil
	end
	
	it "must show interest point" do
		@ability.can :view, InterestPoint
		get :show, scope: :admin, id: @interest_point.id
		assert_response :success, assigns(:interest_point)
	end
	
	it "must approve" do
		skip "investigate failure"
		@ability.can :approve, InterestPoint
		@controller.stubs(:current_user).returns(@user)
		put :approve, scope: :admin, id: @interest_point.id
		assert_response :success
		@interest_point.pending.wont_equal true
	end
	
	it "must unapprove" do
		skip "investigate failure"
		@ability.can :unapprove, InterestPoint
		@controller.stubs(:current_user).returns(@user)
		put :unapprove, scope: :admin, id: @interest_point.id
		assert_response :success
		@interest_point.pending.must_equal true
	end

	describe "for multiple interest points" do

		it "must approve" do
			skip 'investigate failure'
			@ability.can [:update_multiple, :approve_multiple], InterestPoint
			@interest_points = FactoryGirl.create_list(:interest_point, 3)
			interest_point_ids = @interest_points.map{|a| a.id}.to_a
			put :update_multiple, scope: :admin, interest_point_ids: interest_point_ids, params: { 'approve' => 'true'}
			assert_response :success
			@interest_points.each do |interest_point|
				interest_point.pending.wont_equal true
			end
		end

		it "must unapprove" do
			skip 'investigate failure'
			@ability.can [:update_multiple, :unapprove_multiple], InterestPoint
			@interest_points = FactoryGirl.create_list(:interest_point, 3, approver_id: 1, approved_at: DateTime.now)
			# @todo remove this after verification
			@interest_points.each do |interest_point|
				interest_point.pending.wont_equal true
			end
			interest_point_ids = @interest_points.map{|a| a.id}.to_a
			put :update_multiple, scope: :admin, interest_point_ids: interest_point_ids, unapprove: 'unapprove'
			assert_response :success
			@interest_points.each do |interest_point|
				interest_point.pending.must_equal true
			end
		end
	end

	it "must update default image" do
		skip 'investigate failure'
		@image = InterestPoint.update(images_attributes: FactoryGirl.attributes_for(:image))
		@ability.can :update_default_image, @interest_point, @image
		put :update_default_image, scope: :admin, interest_point: @interest_point, image_id: @image
		assert_response :success
		@interest_point.default_image.must_equal @image
	end
end
