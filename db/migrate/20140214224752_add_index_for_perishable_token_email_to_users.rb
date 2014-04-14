class AddIndexForPerishableTokenEmailToUsers < ActiveRecord::Migration
  def change
  	add_index :users, :perishable_token  
	add_index :users, :email  
  end
end
