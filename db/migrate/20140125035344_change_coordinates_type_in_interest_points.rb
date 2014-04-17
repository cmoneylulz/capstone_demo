class ChangeCoordinatesTypeInInterestPoints < ActiveRecord::Migration
  def change
  	remove_column :interest_points, :latitude, :decimal
  	remove_column :interest_points, :longitude, :decimal
  	add_column :interest_points, :latitude, :float
  	add_column :interest_points, :longitude, :float
  end
end
