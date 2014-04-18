class FixMigrationInArtistInterestPointsBrokenInMerge < ActiveRecord::Migration
  def change
  	remove_column :artist_interest_points, :interest_point
  	remove_column :artist_interest_points, :references
  	add_reference :artist_interest_points, :interest_point, index: :true
  end
end
