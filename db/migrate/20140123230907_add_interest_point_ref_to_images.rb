class AddInterestPointRefToImages < ActiveRecord::Migration
  def change
    add_reference :images, :interest_point, index: true
  end
end
