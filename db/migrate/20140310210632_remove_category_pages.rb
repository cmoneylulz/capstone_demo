class RemoveCategoryPages < ActiveRecord::Migration
  def change
  	drop_table :category_pages
  end
end
