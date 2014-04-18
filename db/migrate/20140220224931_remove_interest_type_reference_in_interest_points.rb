class RemoveInterestTypeReferenceInInterestPoints < ActiveRecord::Migration
  def change
  	remove_reference :interest_points, :interest_type
  end
end
