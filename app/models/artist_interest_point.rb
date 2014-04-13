# == Schema Information
#
# Table name: artist_interest_points
#
#  id                :integer          not null, primary key
#  artist_id         :integer
#  created_at        :datetime
#  updated_at        :datetime
#  interest_point_id :integer
#

class ArtistInterestPoint < ActiveRecord::Base
  belongs_to :artist
  belongs_to :interest_point

end
