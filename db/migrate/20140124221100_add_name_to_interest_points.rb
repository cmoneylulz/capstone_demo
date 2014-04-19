class AddNameToInterestPoints < ActiveRecord::Migration
  def change
    add_column :interest_points, :name, :string
  end
end
