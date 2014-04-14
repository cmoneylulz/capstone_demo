class ChangeRatingsToPolymorphic < ActiveRecord::Migration
  def change
		drop_table :comment_ratings
		rename_table :interest_point_ratings, :ratings
		remove_reference :Ratings, :interest_point
		add_reference :Ratings, :ratable, polymorphic: true, index: true
  end
end
