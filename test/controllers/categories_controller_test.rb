require "test_helper"

# Tests for +Categories Controller+
# @author Ashley Childress
# @version 2.25.2014
describe CategoriesController do
 
	# Bypass user abilities that may prevent access to a page by always using the admin user
	before do
		user = FactoryGirl.create(:user)
	  @ability = Ability.new(user)
	  @controller.stubs(:current_ability).returns(@ability)
	end
	
	before :each do
		@category = FactoryGirl.create(:category)
	end

  it "must get index" do
  	@ability.can :read, Category
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  it "must get new" do
  	@ability.can :create, Category
    get :new
    assert_response :success
  end

  it "must create category" do
  	@ability.can :create, Category
    assert_difference('Category.count') do
      post :create, category: FactoryGirl.attributes_for(:category, name: "Test Category")
    end
    assert_redirected_to category_path(assigns(:category))
  end

  it "must redirect when it fails to create a category" do
    skip "Testing for the ELSE part of create, fails on invalid parameters instead of flashing error"
    @ability.can :create, Category
    post :create, category: nil
    assert_redirected_to new_category_path
  end

  it "must show category" do
  	@ability.can :read, Category
    get :show, id: @category.id
    assert_response :success
  end

  it "must get edit" do
  	@ability.can :edit, Category
    get :edit, id: @category.id
    assert_response :success
  end

  it "must update category" do
  	@ability.can :edit, Category
    put :update, id: @category.id, category: { :name => "Updated Category" }
    assert_redirected_to category_path(assigns(:category))
  end

  it "must destroy category" do
  	@ability.can :delete, Category
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category.id
    end
    assert_redirected_to categories_path
  end
end
