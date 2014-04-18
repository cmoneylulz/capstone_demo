require 'test_helper'

# Used to test basic functionality of the +UserMailer+ to ensure that the emails generated contain the correct context.
# @author Ashley Childress
# @version 2.16.2014 > 3.9.2014
describe UserMailer do
	describe "for valid user" do	
		before :each do
			@user = FactoryGirl.create(:user)
		end
	
		it "sends welcome message" do
			welcome_email = UserMailer.welcome_email(@user)
			welcome_email.deliver
			ActionMailer::Base.deliveries.wont_be :empty?
			
			welcome_email.from.must_equal ["webmaster@interestpoint.com"]
			welcome_email.to.must_equal [@user.email.to_s]
			welcome_email.subject.include?("Welcome").must_equal true			
		end
				
		it "sends reset password instructions" do
			password_reset_email = UserMailer.reset_password_instructions(@user)
			password_reset_email.deliver			
			ActionMailer::Base.deliveries.wont_be :empty?
			
			password_reset_email.to.must_equal [@user.email.to_s]
			password_reset_email.subject.include?("Password reset").must_equal true
		end
	end
	
	describe "for invalid user" do
		before :each do
				@user = FactoryGirl.build(:user)
		end
		
		it "sends missing user email" do
				missing_user_email = UserMailer.missing_user(@user.email)
				missing_user_email.deliver
				ActionMailer::Base.deliveries.wont_be :empty?
				
				missing_user_email.to.must_equal [@user.email.to_s]
				missing_user_email.subject.include?("Password reset").must_equal true
		end
	end
	
end
