require "test_helper"

# Defines test methods for the +AdminMailer+ which should be used to generate and send emails from the administrator group
# @author Ashley Childress
# @version 3.3.2014
describe AdminMailer do
  
  it "must generate update interest point" do
    ip = FactoryGirl.build(:interest_point)
    update_email = AdminMailer.update_interest_point(ip)
    update_email.deliver
    ActionMailer::Base.deliveries.wont_be :empty?
    
    update_email.from.must_equal ["administrators@hotspots.com"]
    update_email.to.must_equal [ip.contributor.email.to_s]
    update_email.subject.include?("needs your attention").must_equal true
  end
  
  it "must generate pending interest point" do
  	User.stubs(:admin).returns(FactoryGirl.create_list(:user, 1))
  	interest_point = FactoryGirl.create(:interest_point)
  	InterestPointsController.any_instance.stubs(:contributor).returns(FactoryGirl.build(:user))
  	interest_point.save.must_equal true
  	
  	pending_email = AdminMailer.new_pending_interest_point(interest_point)
  	pending_email.deliver
  	ActionMailer::Base.deliveries.wont_be :empty?
  	
  	pending_email.to.count.must_equal User.admin.count
  	pending_email.subject.include?("Interest Point pending").must_equal true
  end
  
  it "must generate pending image" do
  	User.stubs(:admin).returns(FactoryGirl.create_list(:user, 3))
  	image = FactoryGirl.create(:image)
  	pending_email = AdminMailer.new_pending_image(image)
  	pending_email.deliver
  	ActionMailer::Base.deliveries.wont_be :empty?
  	
  	pending_email.to.count.must_equal User.admin.count
  	pending_email.subject.include?("Image pending").must_equal true
  	pending_email.body.include?("img").must_equal true
  end
end
