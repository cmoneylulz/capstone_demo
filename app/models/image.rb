# == Schema Information
#
# Table name: images
#
#  id                :integer          not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  file              :string(255)
#  interest_point_id :integer
#  approver_id       :integer
#  approved_at       :datetime
#  contributor_id    :integer
#

# An Image represents a single picture that may be uploaded for an POI instance. This version has been updated to use carrierwave instead of paperclip.
# @author Ashley Childress
# @version 2.11.2014
class Image < ActiveRecord::Base
	
	belongs_to :interest_point, inverse_of: :images#, touch: true#, :counter_cache => true
	has_one :default_interest_point, class_name: 'InterestPoint', inverse_of: :default_image
 	belongs_to :contributor, class_name: 'User', foreign_key: 'contributor_id'
 	belongs_to :approver, class_name: 'User', foreign_key: 'approver_id' 
 	
	mount_uploader :file, ImageUploader
	
	scope :pending, -> { where(approver_id: nil) }
	scope :active, -> { where.not(approver_id: nil) }
	
	validates_presence_of :interest_point, :contributor, :file
	
	def pending
		self.approver_id.nil?
	end
	
	def default?
		return false if self.interest_point.default_image.nil?
		self.interest_point.default_image.eql?(self)
	end
		
	# Generate and deliver the +New Pending Interest Point+ email for this +Interest Point+.
	# @pre the +Interest Point+ is +pending+
	# @post a new email will be generated and sent to all application administrators for this +Interest Point+
	def notify_administrators!
		AdminMailer.new_pending_image(self).deliver!
	end

	private

	# @api private
	# Defines a valid +contributor_id+ for this +Image+
	# @post +self.contributor => current_user || User.guest
	def set_contributor
		self.contributor = current_user.nil? ? User.guest : current_user
	end
end
