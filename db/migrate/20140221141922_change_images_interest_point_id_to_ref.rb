class ChangeImagesInterestPointIdToRef < ActiveRecord::Migration
  def change
  	remove_column :images, :interest_point_id
  	add_reference :images, :interest_point, index: true
  end
end
