require 'test_helper'

# Tests methos defined for an +InterestPoint+ model
# @author Ashley Childress,
# @version 1.24.2014 > 3.13.2014
describe InterestPoint do
	
	it "is valid with valid params" do
		ip = FactoryGirl.build(:interest_point)
		ip.must_be :valid?
		ip.save.must_equal(true)
	end
	
	it "defines contributor and created_at when saved" do
		ip = FactoryGirl.create(:interest_point)
		ip.contributor.wont_be_nil
		ip.created_at.wont_be_nil
	end
	
	it "is invalid without name" do
		FactoryGirl.build(:interest_point, name: "").wont_be :valid?
	end
	
	it "is invalid without location" do
		proc { FactoryGirl.create(:interest_point, address_line_1: "", address_line_2: "", city: "", state: "", zip: "", latitude: "", longitude: "") }.must_raise ActiveRecord::RecordInvalid
	end
		
	it "gets address when given coordinates" do
		ip = FactoryGirl.create(:interest_point, latitude: 33.5801100, longitude: -85.0766100)
		ip.reverse_geocode
		ip.city.wont_be_nil
		ip.zip.wont_be_nil
	end
		
	it "gets coordinates and crops to six decimal places when given address" do
		ip = FactoryGirl.build(:interest_point, address_line_1: "University of West Georgia", city: "Carrollton", state: "GA")
		ip.geocode.wont_be_nil
		ip.save.must_equal true
		ip.latitude.to_s.split(".")[1].length.wont_be :>, 7
		ip.longitude.to_s.split(".")[1].length.wont_be :>, 7
	end
	
	it "is pending when not approved" do
		FactoryGirl.create(:interest_point).pending.must_equal true
	end
	
	it "is not pending when approved" do
		FactoryGirl.create(:interest_point_approved).pending.must_equal false
	end
	
	it "notifies administrators" do
	  ip = FactoryGirl.create(:interest_point)
	  ip.pending.must_equal true
	  ip.notify_administrators!
	  ActionMailer::Base.deliveries.wont_be :empty?
	end
end