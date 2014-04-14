# == Schema Information
#
# Table name: category_pages
#
#  id                :integer          not null, primary key
#  category_id       :integer
#  interest_point_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class CategoryPage < ActiveRecord::Base
  belongs_to :category
  belongs_to :interest_point
end
