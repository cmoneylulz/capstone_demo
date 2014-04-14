require 'test_helper'

# This test should be used to ensure all pages are properly loaded when called in the ResetPasswordsController
# @author Ashley Childress
# @version 2.16.2014
describe ResetPasswordsController do
	
	# Bypass user abilities that may prevent access to a page by always using the admin user
	before do
		user = FactoryGirl.create(:user)
	  @ability = Ability.new(user)
	  @controller.stubs(:current_ability).returns(@ability)
	end	
	
	before :each do
		@user = FactoryGirl.create(:user)
	end
	
		
	describe "with no current user" do
		before :each do			
			@controller.stubs(:require_no_user).returns(true)
		end
	end
	
	test "should display new if no user logged in" do
		
	end
	
	test "should not get new if user logged in" do	
		skip "Not yet implemented"
	end
	
	test "should get edit if user loaded with token" do
		skip "Not yet implemented"
	end
	
	test "should not get edit if no user loaded with token" do
		skip "Not yet implemented"
	end	
	
end
