require 'test_helper'

# Defines integration tests for all +Interest Point+ actions that may be executed by a nil or guest +user+
# @author Ashley Childress
# @version 3.14.2014

describe 'Interest Points Integration', feature: true do
	describe 'GET #index' do
		before :each do
			visit interest_points_path
		end

		it "must include all active interest points" do

		end

		it "must display show link" do

		end

		context "ability granted" do
			before do

			end

			it "displays create link" do

			end

			it "displays edit link" do

			end

			it "displays delete link" do

			end
		end

		context "ability prohibited" do
			before do

			end

			it "wont display create link" do

			end

			it "wont display edit link" do

			end

			it "wont display delete link" do

			end
		end
	end

	describe 'GET #show' do
		before :each do
			@interest_point = FactoryGirl.create(:interest_point)
			visit interest_point_path(@interest_point)
		end

		it "must allow image upload" do

		end

		it "must display active images" do

		end

		it "wont display pending images" do

		end

		it "displays comments" do

		end

		context "ability granted" do
			it "displays edit link" do

			end

			it "displays delete link" do

			end
			it "can create comment" do

			end
		end

		context "ability prohibited" do
			it "wont display edit link" do

			end

			it "wont display delete link" do

			end
		end
	end

	describe 'GET #edit' do
		before :each do
			@interest_point = FactoryGirl.create(:interest_point)
			visit edit_interest_point_path(@interest_point)
		end

		it "must display errors with invalid form" do

		end

		it "updates interest point with valid form" do

		end
	end

	describe 'GET #new' do
		before :each do
			visit new_interest_point_path
		end

		it "must display errors with invalid form" do

		end

		it "must create interest point with valid form" do

		end
	end
end