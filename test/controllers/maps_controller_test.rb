require 'test_helper'

describe MapsController do
	before :all do
		@user = FactoryGirl.create(:user)
		@ability = Ability.new(@user)
		@controller.stubs(:current_ability).returns(@ability)
		@controller.stubs(:current_user).returns(@user)
	end

  it "must get main" do
	  get :main
    assert_response :success
  end

  it "must get show" do
    get :show, id: 1
    assert_response :success
  end

end
