class AddInterestPointRefToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :interest_point, index: true
  end
end
