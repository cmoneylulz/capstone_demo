class DropInterestTypes < ActiveRecord::Migration
  def change
  	drop_table :interest_types
  end
end
