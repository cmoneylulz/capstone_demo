class RemoveOldPhotoFromImages < ActiveRecord::Migration
  def change
  	remove_column :images, :photo_file_name
  	remove_column :images, :photo_content_type
  	remove_column :images, :photo_file_size
  	remove_column :images, :photo_updated_at
  end
end
