# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# This +Category+ represents a collection of similar +Interest Points+ in this application and can be used to help users see all +Interest Points+ for a specific type, including sample images, or this class may be used as a filter on the main map page.
# @author Ashley Childress
# @version 2.20.2014
class Category < ActiveRecord::Base
		
	# +Comments+ may be defined for this specific +Category+ object
	has_many :comments, as: :commentable, dependent: :destroy
	
	# A +Category+ should be associated with many +Interest Points+
	has_many :interest_points, inverse_of: :category

	validates :name,
		presence: true,
		uniqueness: true
	
end
