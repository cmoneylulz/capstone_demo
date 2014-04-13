# == Schema Information
#
# Table name: interest_points
#
#  id               :integer          not null, primary key
#  summary          :text
#  created_at       :datetime
#  updated_at       :datetime
#  contributor_id   :integer
#  approver_id      :integer
#  approved_at      :datetime
#  latitude         :float
#  longitude        :float
#  name             :string(255)
#  address_line_1   :string(255)
#  address_line_2   :string(255)
#  city             :string(255)
#  state            :string(255)
#  zip              :string(255)
#  category_id      :integer
#  default_image_id :integer
#

# An +Interest Point+ is a specific instance of any location that may have special meaning to one or more users. Once an +Interest Point+ is added to the application by a user, others are able to locate that instance on a map, view specific details, and leave individual Comments.  User are also able to share an +Interest Point+ with a friend using our share feature (future). 
# @author	Ashley Childress
# @version 1.23.2014
class InterestPoint < ActiveRecord::Base

	scope :pending, -> { where(approver_id: nil) }
	scope :active, -> { where.not(approver_id: nil) }
	
	belongs_to :contributor, :class_name => 'User', :foreign_key => 'contributor_id'
	belongs_to :approver, :class_name => 'User', :foreign_key => 'approver_id'
	belongs_to :category, inverse_of: :interest_points

  # One or more +Rating+ objects belong to this +InterestPoint+
  has_many :ratings, as: :ratable, dependent: :destroy

  belongs_to :artist

  # One or more +ArtistInterestPoint+ objects may be associated with this +InterestPoint+
  has_many :artist_interest_points

  # One or more +Comment+ object that may be associated with this +InterestPoint+.
	# @return [Array<Comment>]
	has_many :comments, as: :commentable, dependent: :destroy
	
	# A set of images that have been uploaded by the user that show this +Interest Point+.	
	# @see #Image
	# @note Only .jpg, .jpeg, .gif, or .png files are acceptable.
	belongs_to :default_image, class_name: 'Image', foreign_key: 'default_image_id', inverse_of: :default_interest_point
	has_many :images, dependent: :destroy, inverse_of: :interest_point
	accepts_nested_attributes_for :images, allow_destroy: true, reject_if: lambda { |a| a[:file].blank? }
	
	# Ensures each +Interest Point+ has a valid +name+ and +category_id+
	validates_presence_of :name, :category, :contributor
	
	# If this +Interest Point+ does not have a valid +address+, then also ensure both the +latitude+ and +longitude+ are defined
	validates_presence_of :latitude, :longitude, if: Proc.new { |a| a.full_address.split(", ").join(" ").blank? }
	
	# Ensure information entered for the address is geocoded to generate latitude & longitude
	geocoded_by :full_address
	reverse_geocoded_by :latitude, :longitude do |obj, results|
		if geo = results.first
			obj.city = geo.city
			obj.zip = geo.postal_code
			address = geo.address.split(", ")
			obj.address_line_1 = address[0] unless address[0].empty?
		end
	end

	after_validation :geocode, :reverse_geocode
	
	# Make sure the coordinates are rounded to six decimal places and address information is formatted alike
	before_save :normalize_coordinates

	# @return A single string containing all address fields entered by the user
	def full_address
		[self.address_line_1, self.address_line_2, self.city, self.state, self.zip].compact.join(", ")
	end
			
	# @return [boolean] true if this +Interest Point+ has not yet been approved; otherwise, false.
	def pending
		return self.approver.nil?
  end

  # Generate and deliver the +New Pending Interest Point+ email for this +Interest Point+.
  # @pre the +Interest Point+ is +pending+
  # @post a new email will be generated and sent to all application administrators for this +Interest Point+
  def notify_administrators!
    AdminMailer.new_pending_interest_point(self).deliver!
  end
	
	protected
	
	# Ensure the given +latitude+ and +longitude+ coordinates are rounded to six decimal places.
	# @pre The +latitude+ and +longitude+ must be defined as valid decimal values before this method is called
	# @post The +latitude+ and +longitude+ values are replaced with their equivalent values rounded to four decimal places
	def normalize_coordinates	
		self.latitude = latitude.round(6) unless self.latitude.nil?
		self.longitude = longitude.round(6) unless self.longitude.nil?
	end
	
end
