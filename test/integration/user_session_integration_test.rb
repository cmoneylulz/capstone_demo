require 'test_helper'

# Defines sunny day and rainy day test scenarios for user login
# @author Ashley Childress
# @version 3.14.2014
describe 'User Session Integration', feature: true do
	before :each do
		visit login_path
	end

	describe "Login" do

		it "must define login" do
			page.text.must_include "Login"
		end

		it "must log in valid user" do
			user = FactoryGirl.create(:user)
			fill_in 'User name', with: user.user_name
			fill_in 'Password', with: user.password
			click_button 'Login'
			current_path.must_equal root_path
			page.must_have_content 'Login successful'
		end

		it "must fail with invalid user" do
			fill_in 'User name', with: 'testusername'
			fill_in 'Password', with: ''
			click_button 'Login'
			page.must_have_content 'unable to locate that account'
		end

		it "must cancel" do
			click_on 'Cancel'
			current_path.must_equal root_path
		end
	end

	describe 'Create account' do
		before :each do
			click_link 'Create'
		end

		it "must open new user" do
			current_path.must_equal new_user_path
			page.must_have_content 'New User'
		end

		it "must create new user with valid form" do
			user = FactoryGirl.build(:user)
			fill_in 'User name', with: user.user_name
			fill_in 'Password', with: 'Password1'
			fill_in 'Password confirmation', with: 'Password1'
			fill_in 'First name', with: user.first_name
			fill_in 'Last name', with: user.last_name
			fill_in 'Email', with: user.email
			click_on 'Create User'
			page.must_have_content 'Your account has been successfully created'
			last_email.to.first.must_equal user.email
			last_email.body.must_include 'Thanks for signing up'
			current_path.must_equal root_path
		end

		it "must display validation error with invalid form" do
			click_on 'Create User'
			page.must_have_content 'User name can\'t be blank'
			page.must_have_content 'Create New User'
		end

		it "must return if cancel" do
			click_on 'Cancel'
			current_path.must_equal root_path
			page.must_have_content 'Login'
		end
	end

	# @todo might not need this section after reset passwords controller is implemented
	describe 'Forgot Password' do
		before :each do
			click_on 'Forgot password?'
		end

		it "must open reset passwords" do
			page.must_have_content('Reset Password')
		end

		it "must email password for valid user" do
			skip "investigate click button"
			user = FactoryGirl.create(:user)
			fill_in 'Email', with: user.email
			click_on 'Send'
			last_email.to.must_equal user.email
			last_email.body.must_include 'A request to reset your password'
			current_path.must_equal root_path
			page.must_have_content 'Instructions'
		end

		it "must email missing user for invalid user" do
			skip "investigate click button"
			fill_in 'Email', with: 'nonexisting@noemail.com'
			click_button 'Send me email'
			last_email.to.first.must_equal 'nonexisting@noemail.com'
			last_email.body.must_include 'We apologize'
			current_path.must_equal root_path
			page.must_have_content 'Instructions'
		end

		it "must display errors with invalid form" do
			skip "investigate click button"
			click_button 'Send me email'
			current_path.must_equal new_reset_password_path
			page.must_have_content 'Email can\t be blank'
		end
	end

	describe "Reset forgotten password" do
		before do
			click_on 'Forgot password?'
			@user = FactoryGirl.create(:user)
			fill_in 'Email', with: @user.email
			click_on 'Send me email'
			@new_token = @user.perishable_token
		end

		it "must display error with invalid token" do
			visit edit_reset_password_path('arandomresetpasswordtoken')
			current_path.must_equal root_path
			page.must_have_content 'We apologize'
		end

		it "must open reset password link" do
			visit edit_reset_password_path(@new_token)
			current_path.must_equal edit_reset_password_path(@new_token)
			page.must_have_content 'Update your password'
		end

		it "must display error for invalid form" do
			visit edit_reset_password_path(@new_token)
			click_on 'Update Password'
			current_path.must_equal reset_password_path(@new_token)
			page.must_have_content 'can\'t be blank'
		end

		it "must reset password with valid form" do
			visit edit_reset_password_path(@new_token)
			fill_in 'Password', with: 'Password1'
			fill_in 'Password confirmation', with: 'Password1'
			click_on 'Update Password'
			current_path.must_equal login_path
			page.must_have_content 'Your password was successfully updated'
		end

	end

	# The following Social sign in tests assume correct operation of OmniAuth
	describe "Social sign in" do

		it "must work for new google user" do
			skip "troubleshoot button click"
			mock_google_hash
			find('google-login').click
			current_path.must_equal '/auth/google_oauth2/callback'
		end

		it "must work for new twitter user" do
			skip "troubleshoot button click"
			mock_twitter_hash
			find('twitter-login').click
			current_path.must_equal '/auth/twitter/callback'
		end

		it "must work for new facebook user" do
			skip "troubleshoot button click"
			mock_facebook_hash
			find('facebook-login').click
			current_path.must_equal '/auth/facebook/callback'
		end

		it "must have error with invalid credentials" do
			skip "troubleshoot button click"
			mock_invalid_hash
			find('#twitter-login').click
			current_path.must_equal root_path
		end
	end

	describe "Logout" do
		before do
			user = FactoryGirl.create(:user)
			fill_in 'User name', with: user.user_name
			fill_in 'Password', with: user.password
			click_button 'Login'
			current_path.must_equal root_path
			page.must_have_content 'Login successful'
		end

		it "must log user out" do
			click_on 'Logout'
			current_path.must_equal root_path
			page.must_have_content 'Logout successful'
		end
	end

end