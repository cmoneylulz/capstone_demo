require "test_helper"

# Defines tests for a +Role+ object
# @author Ashley Childress
# @version 2.24.2014
describe Role do
	
	it "is valid with name" do
		FactoryGirl.build(:role).must_be :valid?
	end
	
	it "is invalid when name is fewer than 3 characters" do
		FactoryGirl.build(:role, name: "a").wont_be :valid?
	end
	
	it "is valid when name has exactly 3 characters" do
		FactoryGirl.build(:role, name: "132").must_be :valid?
	end
	
	it "is saved with valid params" do
		r = FactoryGirl.build(:role)
		r.save.must_equal true
	end
	
end
