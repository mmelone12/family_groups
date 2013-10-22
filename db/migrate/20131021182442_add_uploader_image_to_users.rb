class AddUploaderImageToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :uploader_image, :string
  end
end
