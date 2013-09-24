class AddOriginalRecordToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :original_record, :boolean, default: false
  end
end
