require 'test_helper'

# Test methods for a +Category+ object
# @author Ashley Childress
# @version 2.25.2014
describe Category do
	
	it "is valid with name" do
		FactoryGirl.create(:category).must_be :valid?
	end
	
	it "is not valid with same name" do
		same_name = FactoryGirl.create(:category).name
		FactoryGirl.build(:category, name: same_name).wont_be :valid?
	end
	
	it "is not valid with no name" do
		FactoryGirl.build(:category, name: "").wont_be :valid?
	end
	
end