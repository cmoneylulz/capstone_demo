# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Artist < ActiveRecord::Base
  has_many :interest_points
  has_many :artist_interest_points
  
  validates_presence_of :first_name, :last_name
end
