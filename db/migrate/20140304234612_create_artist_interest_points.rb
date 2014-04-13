class CreateArtistInterestPoints < ActiveRecord::Migration
  def change
    create_table :artist_interest_points do |t|
      t.references :artist, index: true
      t.string :interest_point
      t.string :references

      t.timestamps
    end
  end
end
