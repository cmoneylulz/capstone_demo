class ChangeFilePathToAttachmentInImages < ActiveRecord::Migration
  def up
  	remove_column :images, :file_path
  	add_attachment :images, :photo
  end
  
  def down
  	add_column :images, :file_path, :string
  	remove_attachment :images, :photo
  end
end
