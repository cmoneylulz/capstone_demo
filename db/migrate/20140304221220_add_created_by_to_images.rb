class AddCreatedByToImages < ActiveRecord::Migration
  def change
    add_reference :images, :contributor, index: :true
  end
end
