class ChangeCommentsToPolymorphic < ActiveRecord::Migration
  def change
  	remove_column :comments, :interest_point_id
  	add_reference :comments, :commentable, polymorphic: true, index: true
  end
end
