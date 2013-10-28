class ChangeDescToTextInInterests < ActiveRecord::Migration
  def change
  	change_column :interests, :desc, :text
  end
end
