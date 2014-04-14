# Defines methods used to send an email to application administrators
# @author Ashley Childress
# @version 3.6.2014 > 3.9.2014
class AdminMailer < ActionMailer::Base
	add_template_helper(TextFormatHelper)
		
	# Set the default email address displayed as the 'From' address in all emails.
  default from: "administrators@hotspots.com"
  
  # Create a new email and send it to the +email+ associated with the +user+ who is defined as a +Contributor+ for the given Interest Point
  # @pre The given +Interest Point+ must have a contributor defined as a valid +user+ in this application
  # @post An email will be generated for the contributing +user+ and associated +email+ address, which requests that a specific Interest Point be updated.
  # @param [InterestPoint] the object whose +contributor+ should receive the generated email
  def update_interest_point(interest_point)
  	@interest_point = interest_point
  	@user = @interest_point.contributor
  	mail(to: @user.email.to_s, subject: "#{@interest_point.name} - Hot Spot needs your attention!")
  end  

	# Send an email to all +Admin Users+ to notify them of a pending +Interest Point+
	def new_pending_interest_point(interest_point)
		@interest_point = interest_point
		mail(to: User.admin.map(&:email), subject: "Interest Point pending approval")
	end
	
	# Send an email to all +Admin Users+ to notify them of a pending +Image+
	def new_pending_image(image)
		@image = image
		mail(to: User.admin.map(&:email), subject: "Image pending approval")
	end
end
