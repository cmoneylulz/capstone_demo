# == Schema Information
#
# Table name: ratings
#
#  id                :integer          not null, primary key
#  ratable_type      :string
#  ratable_id :integer
#  score             :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#

# A +Rating+ represents a user-specified score for an application object
# @author Chris Wilson > Ashley Childress
# @version 3.16.2014
class Rating < ActiveRecord::Base

	# Defines this +Rating+ as polymorphic
  belongs_to :ratable, polymorphic: true

  # Associates this +Rating+ with the +User+ who created it
  belongs_to :user

  validates_presence_of :ratable, :user

	# Get the +average_rating+ for the associated +ratable_type+
	# <tt>average_rating =>
	#     Rating.where(ratable_type: self.ratable_type).sum(score) /
	#     Rating.where(ratable_type: self.ratable_type).count</tt>
	# @return the +average_rating+ for the +ratable_type+ associated with this +Rating+
	def self.average_rating(ratable_object)
		Rating.where(ratable: ratable_object).average(:score).to_f
	end

	# Get the path for this +Rating+, based on its parent +ratable+ object.
	# @return the path for this +Rating+
	# @example <tt>rating = Rating.create(ratable: InterestPoint.find(1), user: current_user, score: 5)
	#             rating.default_path => interest_point_ratings => /interest_point/1/ratings </tt>
	def default_path
		"\"/#{self.ratable_type.pluralize.underscore}/#{self.ratable_id}/ratings/#{self.id}/\"".html_safe
	end

  # Get the +Rating+ for the +current_user+ or a new +Rating+ if none is defined
  # @return a +Rating+ associated with the parent +ratable+ object and +current_user+
  # @api public
	def self.user_rating(ratable_object, current_user)
		return Rating.new(ratable: ratable_object) if current_user.nil?
		Rating.where(ratable: ratable_object, user: current_user).first || Rating.create(ratable: ratable_object, user: current_user)
	end
end
