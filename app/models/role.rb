# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# This +Role+ is intended to be associated with each +User+ object in order to enforce security in the application.
# @author Ashley Childress
# @version 2.24.2014
class Role < ActiveRecord::Base
	
	# Each +Role+ should belong to a +User+ record
	has_many :users
	
	# Ensure the +name+ associated with this +Role+ exists and has at least 3 characters
	validates :name, presence: true, length: { minimum: 3 }
	
end
