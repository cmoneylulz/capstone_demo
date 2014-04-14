class RenameImagesPhotoToFile < ActiveRecord::Migration
  def change
  	remove_column :images, :photo
  	add_column :images, :file, :string
  end
end
