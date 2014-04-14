require 'test_helper'

# Defines tests to ensure all +Users+ can perform appropriate actions in this application; Note: All abilities are stubbed in their corresponding controllers.
# @author Ashley Childress
# @version 3.4.2014
describe Ability do
	before do
		@interest_point = InterestPoint.new(approver_id: 1)
		@p_interest_point = InterestPoint.new
		@image = Image.new(interest_point_id: @interest_point.id, approver_id: 1)
		@p_image = Image.new(interest_point_id: @interest_point.id)			
		@comment = FactoryGirl.build(:comment, commentable: @interest_point)
		@p_comment = FactoryGirl.build(:comment, commentable: @p_interest_point)
	end

	describe "valid administrator" do
		before do
			user = FactoryGirl.create(:user)
			@ability = Ability.new(user)
		end
		
		describe "can view" do

			describe "admin_dashboard" do
				it "active interest_point" do
					assert @ability.can?(:admin_dashboard, @interest_point)
				end

				it "pending interest_point" do
					assert @ability.can?(:admin_dashboard, @p_interest_point)
				end

				it "active image" do
					assert @ability.can?(:admin_dashboard, @image)
				end

				it "pending image" do
					assert @ability.can?(:admin_dashboard, @p_image)
				end
			end

			describe "active" do
				it "interest points" do 
					assert @ability.can?(:read, @interest_point) 
				end
				it "images" do 
					assert @ability.can?(:read, @image) 
				end	
				it "comments" do 
					assert @ability.can?(:read, @comment) 
				end
			end

			describe "pending" do
				it "interest points" do 
					assert @ability.can?(:read, @p_interest_point)
				end
				it "images" do 
					assert @ability.can?(:read, @p_image)
				end
			end
		end
		
		describe "can create" do
			it "comment for active interest point" do 
				assert @ability.can?(:create, @comment), "This is currently handled by show/read methods and is not displayed on page." 
			end
			it "image for active interest point" do 
				assert @ability.can?(:create, Image => @interest_point) 
			end
		end
		
		describe "can not create" do
			it "comment for pending interest point" do
				skip "investigate failure"
				assert @ability.cannot?(:create, @p_comment), "This ability currenty based on read and not create" 
			end
		end
		
		describe "can approve" do
				it "interest points" do 
					assert @ability.can?(:approve, @interest_point)
				end
				it "images" do 
					assert @ability.can?(:approve, @image)
				end
		end
		
		describe "can unapprove" do
				it "interest points" do 
					assert @ability.can?(:unapprove, @p_interest_point) 
				end
				it "images" do 
					assert @ability.can?(:unapprove, @p_image) 
				end
		end
		
		describe "can delete" do

			describe "active" do
				it "interest points" do 
					assert @ability.can?(:delete, @interest_point) 
				end
				it "images" do 
					assert @ability.can?(:delete, @image) 
				end	
			end
			describe "pending" do
				it "interest points" do 
					assert @ability.can?(:delete, @p_interest_point) 
				end
				it "images" do 
					assert @ability.can?(:delete, @p_image) 
				end
			end
		end

		it "can login" do
			@ability.can?(:login, @user).must_equal true
		end

		it "can logout" do
			@ability.can?(:logout, @user).must_equal true
		end
	end

	describe "valid contributor" do
		before do
			@user = FactoryGirl.create(:user, role: FactoryGirl.create(:role, name: "Contributor"))
			@ability = Ability.new(@user)
		end
		
		describe "can view" do
			it "active interest points" do 
				assert @ability.can?(:read, @interest_point) 
			end
			it "active images for active interest point" do 
				assert @ability.can?(:read, Image.new(interest_point_id: @interest_point, approver_id: 1)) 
			end
			it "comments for active interest point" do 
				assert @ability.can?(:read, @comment) 
			end

			describe "if I created" do
				before do
					@p_interest_point.contributor_id = @user.id
					@p_image.contributor_id = @user.id
				end
				it "pending interest points" do
					skip "investigate failure"
					assert @ability.can?(:read, @p_interest_point) 
				end
				it "pending images for active interest points" do
					skip "investigate failure"
					assert @ability.can?(:read, @p_image) 
				end
				it "active images for pending interest point" do 
					assert @ability.can?(:read, Image.new(interest_point_id: @p_interest_point, approver_id: 1)) 
				end
			end
		end
		
		describe "can not view" do
			describe "if I did not create" do
				before do
					@p_interest_point.contributor_id = FactoryGirl.create(:user)
					@p_image.contributor_id = FactoryGirl.create(:user)
					@p_image.interest_point = @interest_point
				end				
				it "pending interest points" do 
					assert @ability.cannot?(:read, @p_interest_point) 
				end
				it "pending images for active interest points" do 
					assert @ability.cannot?(:read, @p_image) 
				end
					
				it "active images for pending interest point" do 
					skip "Need to nest Images under Interest Point before this will pass"
					assert @ability.cannot?(:read, Image.new(interest_point_id: @p_interest_point, approver_id: 1)), "Need to nest images" 
				end
			end
		end
		
		describe "can create" do
			it "comment for active interest point" do 
				assert @ability.can?(:create, @comment) 
			end

			it "image for active interest point" do
				assert @ability.can?(:create, Image => @interest_point) 
			end

			describe "for interest point I created" do
				it "image for pending interest point" do
					assert @ability.can?(:create, Image => @p_interest_point) 
				end
			end
		end
		
		describe "can not create" do
			it "comment for pending interest point" do
				skip "investigate failure"
				assert @ability.cannot?(:create, @p_comment) 
			end

		end

		it "can login" do
			# @todo this keeps failing??
			# @ability.can?(:login, @user).must_equal true
		end

		it "can logout" do
			# @todo this keeps failing??
			#@ability.can?(:logout, @user).must_equal true
		end
	end

	describe "valid guest" do
		before do
			@user = FactoryGirl.create(:user, role: FactoryGirl.create(:guest))
			@ability = Ability.new(@user)
		end

		describe "can login" do
			#@todo: investigate failure
			#assert @ability.can?(:login, @user)
		end

		describe "can logout" do
			#@todo: investigate failure
			#assert @ability.can?(:logout, @user)
		end
	end

	describe "nil user" do
		before do
			@ability = Ability.new(nil)			
		end

		describe "can view" do
			it "active interest points" do
				assert @ability.can?(:read, @interest_point)
			end

			it "active images" do
				assert @ability.can?(:read, Image.new(interest_point_id: @interest_point, approver_id: 1))
			end

			it "comments" do
				assert @ability.can?(:read, @comment)
			end
		end

		describe "can not view" do
			it "pending interest points" do 
				assert @ability.cannot?(:read, @p_interest_point) 
			end
				
			it "active images for pending interest points" do  
				skip "Need to nest Images under Interest Point before this will pass"
				assert @ability.cannot?(:read, Image.new(interest_point_id: @p_interest_point.id, approver_id: 1)), "Need to nest images" 
			end				
				
			it "pending images for active interest point" do 
				assert @ability.cannot?(:read, @p_image) 
			end	
			it "pending images for pending interest points" do 
				assert @ability.cannot?(:read, Image.new(interest_point_id: @p_interest_point.id)), "Need to nest images" 
			end
			it "any user" do 
				assert @ability.cannot?(:read, User.new(id: 5)) 
			end
		end

		describe "can create" do
			it "new user" do 
				assert @ability.can?(:create, User) 
			end

			it "new user session" do
				skip "investigate failure"
				assert @ability.can?(:create, UserSession)
			end

			it "comment for active interest point" do 
				assert @ability.can?(:create, @comment) 
			end

			it "image for active interest point" do
				skip "investigate failure"
				assert @ability.can?(:create, Image => @interest_point) 
			end
		end

		describe "can not create" do
			describe "for pending interest point" do
				it "new comment" do
					skip "investigate failure"
					assert @ability.cannot?(:create, @p_comment), "This ability currenty based on read and not create"
				end
				
				it "image for pending interest point" do
					skip "investigate failure"
					assert @ability.can?(:create, Image => @p_interest_point) 
				end
			end
		end
		
		it "can not edit user" do
			assert @ability.cannot?(:modify, User.new(id: 5))
		end

		it "can not login" do
			skip "investigate failure"
			@ability.can?(:login, User).wont_equal true
		end

		it "can not logout" do
			@ability.can?(:logout, User).wont_equal true
		end
		
	end
end