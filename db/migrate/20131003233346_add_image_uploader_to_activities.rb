class AddImageUploaderToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :uploader_image, :string
  end
end
