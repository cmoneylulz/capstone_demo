class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file_path
      t.timestamps
    end
  end
end
