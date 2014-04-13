class FixNameForDefaultImageReference < ActiveRecord::Migration
  def change
		remove_reference :interest_points, :default_image_id
		add_reference :interest_points, :default_image, index: true
  end
end
