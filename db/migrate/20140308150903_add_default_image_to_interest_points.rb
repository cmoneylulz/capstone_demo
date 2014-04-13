class AddDefaultImageToInterestPoints < ActiveRecord::Migration
  def change
  	add_reference :interest_points, :default_image_id, index: true
  end
end
