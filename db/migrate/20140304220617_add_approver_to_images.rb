class AddApproverToImages < ActiveRecord::Migration
  def change
  	add_reference :images, :approver, index: true
  	add_column :images, :approved_at, :datetime
  end
end
