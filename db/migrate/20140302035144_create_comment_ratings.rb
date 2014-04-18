class CreateCommentRatings < ActiveRecord::Migration
  def change
    create_table :comment_ratings do |t|
      t.references :comment, index: true
      t.references :user, index: true
      t.integer :score, :default => 0

      t.timestamps
    end
  end
end
