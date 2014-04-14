class CreateCategoryPages < ActiveRecord::Migration
  def change
    create_table :category_pages do |t|
      t.references :category, index: true
      t.references :interest_point, index: true

      t.timestamps
    end
  end
end
