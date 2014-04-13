class CreateInterestPointRatings < ActiveRecord::Migration
  def change
    create_table :interest_point_ratings do |t|
      t.references :interest_point, index: true
      t.integer :score, :default => 0

      t.timestamps
    end
  end
end
