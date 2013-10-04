class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.integer :user_id
      t.string :name
      t.string :desc
      t.string :image_path
      t.string :uploader_image
      t.string :city
      t.string :address
      t.string :website
      t.string :link

      t.timestamps
    end
  end
end
