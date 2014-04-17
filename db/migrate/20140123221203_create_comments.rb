class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author_name
      t.text :comment_body
      t.integer :rating
      
      t.timestamps
    end
  end
end
