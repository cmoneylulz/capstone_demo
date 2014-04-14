require 'test_helper'

# Defines tests for all methods defined in the +Test Helper+ class.
# @author Ashley Childress
# @version 3.13.2014
describe TextFormatHelper do
  
	it "must format datetime" do
	  var = Time.local(2013, 3, 13, 11, 30)
	  format_datetime(var).must_equal "March 13, 2013 at 11:30 AM"
	end
	
	it "must format default button" do
	  default_button('\path').must_equal link_to("", '\path', class: "btn btn-xs btn-default")
	end	
	
	it "must format create button" do
	  default_create_button("New Test", '/path').must_equal link_to("<span class=\"glyphicon glyphicon-plus\"></span>New Test".html_safe, '/path', class: "btn btn-xs btn-info")
	end
end