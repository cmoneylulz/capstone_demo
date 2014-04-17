class CreateInterestPoints < ActiveRecord::Migration
  def change
    create_table :interest_points do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :interest_type
      t.text :summary

      t.timestamps
    end
  end
end
