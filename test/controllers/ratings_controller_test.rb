require 'test_helper'

# Defines test for +Rating+ actions
# @author Ashley Childress
# @version 3.16.2014
describe RatingsController do
	before do
		user = FactoryGirl.create(:user)
		@ability = Ability.new(user)
		@controller.stubs(:current_ability).returns(@ability)
	end

	describe "ratable interest point" do
		it "must get index" do

		end

		it "must get new" do

		end

		it "must create rating" do

		end

		it "must get edit" do

		end

		it "must update rating" do

		end
	end


end