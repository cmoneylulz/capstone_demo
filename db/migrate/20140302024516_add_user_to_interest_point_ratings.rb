class AddUserToInterestPointRatings < ActiveRecord::Migration
  def change
    add_reference :Ratings, :user, index: true
  end
end
