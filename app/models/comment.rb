# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  author           :string(255)
#  body             :text
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer
#  commentable_type :string(255)
#

# A Comment represents text left by any user about a specific POI instance.
# @author Ashley Childress
# @version 2.2.2014
class Comment < ActiveRecord::Base
	
	# @attribute! [r] commentable
	# 	@return [Commentable] the parent +object+ this +comment+ is defined for.
	belongs_to :commentable, polymorphic: true
  
  has_many :reports, dependent: :destroy
	
	scope :reported, -> { joins(:reports).uniq }
	
  # may have one or many +CommentRating+
  #has_many :comment_ratings

	# @attribute! author
	# 	@return [String] the name or alias of the person who created this comment
	# @attribute! body
	# 	@return [String] the comment text
	validates_presence_of :author, :body, :commentable

	def times_reported
		Report.where("comment_id = ? ", "#{self.id}").count
	end
	
end
