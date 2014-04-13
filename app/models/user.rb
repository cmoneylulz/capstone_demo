# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)
#  password_hash     :string(255)
#  user_name         :string(255)
#  email             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  persistence_token :string(255)
#  perishable_token  :string(255)
#  password_salt     :string(255)
#  provider          :string(255)
#  uid               :string(255)
#  role_id           :integer
#

# A User is a person that has registered with the application. A User may upload images or leave comments.
# @author Ashley Childress
# @version 1.23.2014
class User < ActiveRecord::Base
  has_many :reports

	# Is associated with exactly one +Role+
	belongs_to :role

  # May have one or more +Rating+
  has_many :ratings
  
  # @return [Boolean] true if this +User+ has an +Admin+ role, otherwise +false+.
  # @example +User.admin+ => list of all administrators
  scope :admin, -> { where(role: Role.find_by(name: "Administrator")) }

  # Ensure this +User+ has a valid +Role+ association before validation
  before_validation :set_valid_role

	# Ensure the +User+ is authenticated in this application with their +user_name+, valid +email+ and encrypted +password+.
	acts_as_authentic do |c|
		c.login_field = :user_name
		c.crypto_provider = Authlogic::CryptoProviders::BCrypt
		
		# Do not validate password or email with BCrypt to avoid errors when signing in with social media
		c.validate_email_field = false
		c.validate_password_field = false
	end
	
	# If the +User+ is created in the application (no social media sign in), then ensure a valid +email+ address exists and a +password+ is defined with at least 8 characters. If the +password+ changes or is being created for the first time, then ensure a valid +password_confirmation+ is also present.
	validates :password, if: Proc.new { |a| a.provider.blank? && a.uid.blank? },
		confirmation: true, if: :password_changed?,
		length: { minimum: 8, allow_blank: true }

	# Ensure a matching +password_confirmation+ exists if the +password+ has been defined
	validates :password_confirmation,
		presence: true, unless: Proc.new { |a| a.password.blank? }

	# Ensure each +User+ has an unique +user_name+ defined with at least 5 characters
	validates :user_name,
		presence: true,
		uniqueness: true,
		length: { minimum: 5 }
			
	# If the +User+ is created using a social media network, then ensure the +provider+ and +uid+ are both defined
	validates_presence_of :provider, :uid, if: Proc.new { |a| a.password.blank? }

	# Ensure all +Users+ have a valid +first_name+ and +last_name+ defined.
	validates_presence_of :first_name, :last_name, :role

	# Ensure every +user_name+ is stored using only lowercase letters
	before_save :normalize_user_name

	# Normalize the user-specified +user name+ by ensuring all characters are lowercase
	def normalize_user_name
		self.user_name = user_name.downcase
	end

  # If no +Role+ is defined for this +User+, then set its value to the 'Guest' role.
  def set_valid_role
		return unless self.role.nil?
		guest_role = Role.find_by(name: 'Guest')
		if guest_role.nil?
			Role.create!(name: 'Guest')
			guest_role = Role.find_by(name: 'Guest')
		end
		self.role = guest_role
  end

  # @api public
	# Ensure this +User+ model's perishable token is reset and send an email to the user to allow her to reset her password
	# @post The token for this +User+ will be reset and an email will be sent to the +email+ address defined for this +User+ using the UserMailer.
	def deliver_reset_password_instructions!
		reset_perishable_token!
		UserMailer.reset_password_instructions(self).deliver!
	end

  # @api public
	# Get the +User+ record with the +provider+ and +uid+ provided in the given +auth+ hash. If no +User+ exists, then a new one will be created.
	# @pre The +User+ has been authenticated using a valid social media network, such as Facebook, Twitter, or Google+.
	# @post The existing +User+ record will be returned or, if the +User+ does not exist, then a new +User+ will be created returned.
	# @param [Hash] auth the hash that contains information for the authenticated +User+
	# @return [User] the +User+ object matching information in the given +auth+ hash
	def self.from_omniauth(auth)
		provider, uid = auth.slice("provider", "uid")
		where(provider, uid.to_i).first || create_from_omniauth(auth)
	end

  # @api public
  # Determine if this +User+ is associated with the given +role_name+
  # @param [String] role_name the name of the +Role+ that should be verified
  # @returns [Boolean] true if the given +role_name => self.role.name+; otherwise, false
	def is?(role_name)
		return false if self.role.nil?
		self.role.name.eql?(role_name)
	end

  # @api public
	# Gets a generic +guest_user+ which can be used in place of a logged in +User+
	# @return a generic +User+ with a +Role+ equal to "Guest"
	def self.guest
		create_guest_user if User.find_by(user_name: 'guestuser').nil?
		User.find_by(user_name: 'guestuser')
	end
	
	private 

  # @api private
	# Create a new +User+ using information contained in the given +auth+ hash.
	# @pre The +User+ has beeen authenticated using a valid social media network, such as Facebook, Twitter, or Google+.
	# @post A new +User+ record will be creatd with the same +user_name+, +first_name+, +last_name+, and +email+. The +User+ will be identified using the +provider+ and +uid+ given in the +auth+ hash.
	# @param [Hash] auth the hash returned after a valid +omniauth+ request is made
	def self.create_from_omniauth(auth)
		create! do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			if user.provider == "google_oauth2"
				user.user_name = auth.info.name.split(' ').join('').downcase # Store user_name as full name without spaces, as lowercase if the nickname can't be used
			else ## Is twitter/facebook
				user.user_name = auth.info.nickname
			end
			user.first_name = auth.info.first_name
			user.last_name = auth.info.last_name

			## Set a random user password to allow sign in
			user.password = rand(36**10).to_s(36)
			user.password_confirmation = user.password

			## Email is not provided by Twitter
			user.email = auth.info.email unless user.provider == "twitter"

			## If the response doesn't contain the first and last names as separate attributes, then create from the whole name
			if user.first_name.nil? || user.last_name.nil?
				name = auth.info.name.split(" ")
				user.first_name = name[0].chomp unless name.length == 1
				user.last_name = name[name.length-1].chomp
			end
			
			## Assign the user to a "Basic" role
			user.role = Role.find_by(name: "Guest")
		end
	end

  # @api private
	# In the event the +guest_user+ does not exist in this application, then create a new one.
	# @pre +User.find_by(user_name: 'guestuser') => nil+
	# @post  +User.find_by(user_name: 'guestuser') => User+
	def self.create_guest_user
		Role.create(name: "Guest") if Role.find_by(name: "Guest").nil?
		User.create(user_name: 'guestuser', password: 'Password3', password_confirmation: 'Password3', first_name: 'Guest', last_name: 'User', email: 'guestuser@email.com', role: Role.find_by(name: "Guest"))
	end


end
