class RenameCommentsFields < ActiveRecord::Migration
  def change
  	rename_column :comments, :author_name, :author
  	rename_column :comments, :comment_body, :body
  end
end
