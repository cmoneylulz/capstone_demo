# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  comment_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Report < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
end
