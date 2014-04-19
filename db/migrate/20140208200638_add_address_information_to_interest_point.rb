class AddAddressInformationToInterestPoint < ActiveRecord::Migration
  def change
    add_column :interest_points, :address_line_1, :string
    add_column :interest_points, :address_line_2, :string
    add_column :interest_points, :city, :string
    add_column :interest_points, :state, :string
    add_column :interest_points, :zip, :string
  end
end
