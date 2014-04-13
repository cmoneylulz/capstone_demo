class ChangeInterestPointsInterestTypeToCategory < ActiveRecord::Migration
  def change
  	remove_column :interest_points, :interest_type
  	add_reference :interest_points, :category, :index => true
  end
end
