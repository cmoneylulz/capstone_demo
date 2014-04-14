require "test_helper"

# Defines tests for all actions defined in the +Roles Controller+
# @author Ashley Childress
# @version 2.24.2014
describe RolesController do
  before do
		user = FactoryGirl.create(:user)
	  @ability = Ability.new(user)
	  @controller.stubs(:current_ability).returns(@ability)
  	# First name called in navigation links, so this line prevents tests that would load those links from failing
  	User.any_instance.stubs(:current_user).returns(user)
  end
  
  before :each do
  	@role = FactoryGirl.create(:role)
  end

  it "must get index" do
  	@ability.can :read, Role
    get :index
    assert_response :success
    assert_not_nil assigns(:roles)
  end

  it "must get new" do
  	@ability.can :create, Role
    get :new
    assert_response :success
  end

  it "must create role" do
  	@ability.can :create, Role
    assert_difference('Role.count') do
      post :create, role: FactoryGirl.attributes_for(:role)
    end
    assert_redirected_to role_path(assigns(:role))
  end

  it "must show role" do
  	@ability.can :read, Role
    get :show, id: @role.id
    assert_response :success
  end

  it "must get edit" do
  	@ability.can :edit, Role
    get :edit, id: @role.id
    assert_response :success
  end

  it "must update role" do
  	@ability.can :edit, Role
    put :update, id: @role.id, role: { name: "Updated Role" }
    assert_redirected_to role_path(assigns(:role))
  end

  it "must destroy role" do
  	@ability.can :delete, Role
    assert_difference('Role.count', -1) do
      delete :destroy, id: @role.id
    end
    assert_redirected_to roles_path
  end

end
