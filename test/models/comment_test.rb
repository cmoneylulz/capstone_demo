require 'test_helper'

# Tests for a new +Comment+
# @author Ashley Childress
# @version 2.25.2014
describe Comment do
	
	it "is valid with valid params" do
		FactoryGirl.create(:comment).must_be :valid?
	end
	
	it "is not valid without author" do
		FactoryGirl.build(:comment, author: "").wont_be :valid?
	end
	
	it "is not valid without body" do
		FactoryGirl.build(:comment, body: "").wont_be :valid?
	end
	
	it "is not valid without commentable" do
		FactoryGirl.build(:comment, commentable: nil).wont_be :valid?
	end
	
end