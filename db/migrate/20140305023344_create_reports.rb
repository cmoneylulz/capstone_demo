class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :comment, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
