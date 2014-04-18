require 'test_helper'

# Tests for Images that are uploaded and saved using Carrierwave
# @author Ashley Childress
# @version 3.1.2014
describe Image do
	
	before :each do
		@interest_point = FactoryGirl.create(:interest_point)
		@image = FactoryGirl.build(:image, interest_point: @interest_point)
	end
	
	it "is valid with image" do
		@image.must_be :valid?
	end
	
	it "will save image if valid" do
		@image.save.must_equal true
		@image.file.wont_be_nil
	end
	
	it "will raise error if invalid file" do
		proc { FactoryGirl.create(:image, file: File.new("#{Rails.root}/test/support/no_picture.txt")) }.must_raise ActiveRecord::RecordInvalid
	end
		
	it "is pending if not approved" do
		@image.pending.must_equal true
	end
	
	it "is active if approved" do
		@image.approver_id = 1
		@image.pending.must_equal false
	end

	it "returns default? true if is default" do
		@image.interest_point.default_image = @image
		@image.default?.must_equal true
	end

	it "returns default? false if not default" do
		@interest_point.default_image = nil
		@image.default?.must_equal false
	end

	it "notifies administrators when pending" do
		image = FactoryGirl.create(:image, interest_point: @interest_point, approver_id: nil, approved_at: nil)
		image.notify_administrators!
		ActionMailer::Base.deliveries.wont_be :empty?
	end
end