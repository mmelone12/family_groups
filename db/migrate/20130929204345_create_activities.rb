class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.string :image_path
      t.date :start_date
      t.date :end_date
      t.string :desc
      t.string :city

      t.timestamps
    end
  end
end
