require 'test_helper'
#require 'omniauth_helper'

# Test methods defined for creating a +User+
# @author Ashley Childress
# @version 2.24.2014
describe User do
	describe "is valid" do
		it "with username and password" do
			FactoryGirl.build(:user).must_be :valid?
		end
		it "created from omniauth" do
			FactoryGirl.build(:user_from_social_media).must_be :valid?
		end

	end

	describe "is invalid" do
		it "if user name is not unique" do
			same_name = FactoryGirl.create(:user).user_name
			FactoryGirl.build(:user, user_name: same_name).wont_be :valid?
		end

		it "if user name has fewer than 5 characters" do
			FactoryGirl.build(:user, user_name: "abc").wont_be :valid?
		end

		it "if password does not match confirmation" do
			FactoryGirl.build(:user, password: "Password1", password_confirmation: "aTotallyDifferentPassword").wont_be :valid?
		end

		it "without password confirmation" do
			FactoryGirl.build(:user, password_confirmation: "").wont_be :valid?
		end

		it "without first name" do
			FactoryGirl.build(:user, first_name: "").wont_be :valid?
		end

		it "without last name" do
			FactoryGirl.build(:user, last_name: "").wont_be :valid?
		end

		it "with no email" do
			skip "Email is not currently checked in User model"
			FactoryGirl.build(:user, email: "").wont_be :valid?
		end

		it "if password is less than 8 characters" do
			FactoryGirl.build(:user, password: "pass", password_confirmation: "pass").wont_be :valid?
		end
	end

	it "will have guest role at validate? if nil" do
		user = FactoryGirl.create(:user, role: nil)
		user.role.name.must_equal 'Guest'
	end

	it "must save user name in lowercase" do
		FactoryGirl.create(:user, user_name: "WYATTETHAN").user_name.must_equal "wyattethan"
	end
		
	it "is? false with different role" do
		FactoryGirl.create(:user).is?("Guest").must_equal false
	end
	
	it "is? true with same role" do
		FactoryGirl.create(:user).is?("Administrator").must_equal true
	end
	
	it "resets token on password reset" do
		u = FactoryGirl.create(:user)
		u.perishable_token.wont_be_nil
		token = u.perishable_token
		u.deliver_reset_password_instructions!
		ActionMailer::Base.deliveries.wont_be :empty?
		
		u.perishable_token.wont_equal token
	end
	
	
	describe "omniauth validation" do

		it "creates new user from omniauth" do
			u = FactoryGirl.build(:user_from_social_media, provider: 'twitter')
			auth = OmniAuth::AuthHash.new({
					                              provider: u.provider,
					                              uid: u.uid,
					                              info: {
							                              first_name: u.first_name,
							                              last_name: u.last_name,
							                              nickname: u.user_name,
					                                  email: u.email
					                              }
			                              })
			user = User.create_from_omniauth(auth)

			user.wont_be_nil
			user.provider.must_equal u.provider
			user.uid.must_equal u.uid
			user.user_name.must_equal u.user_name.downcase
			user.first_name.must_equal u.first_name
			user.last_name.must_equal u.last_name
			user.password.wont_be_nil
			#user.email.must_equal u.email
			user.is?('Guest').must_equal true
		end
		
		it "sets existing user from social media" do
			u = FactoryGirl.create(:user_from_social_media, provider: 'google_oauth2')
			auth = OmniAuth::AuthHash.new({
					                       provider: u.provider,
					                       uid: u.uid,
					                       info: {
																	first_name: u.first_name,
																	last_name: u.last_name,
																	nickname: u.user_name
																}
			                       })
			assert_no_difference('User.count') do
				user = User.from_omniauth(auth)
			end		
		end
		
	end	

	it "gets existing guest_user" do
		a_guest = FactoryGirl.create(:user, user_name: 'guestuser', role: FactoryGirl.create(:guest))
		User.guest.must_equal a_guest
	end
	
	it "gets new guest_user" do
		User.find_by(user_name: 'guestuser').must_be_nil
		guest_user = User.guest
		guest_user.wont_be_nil
		guest_user.user_name.must_equal 'guestuser'
	end
end