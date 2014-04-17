class AddRefUsersToInterestPoints < ActiveRecord::Migration
  def change
    add_reference :interest_points, :contributor, index: true
    add_reference :interest_points, :approver, index: true
    add_column :interest_points, :approved_at, :datetime
  end
end
