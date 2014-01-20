class AddNameColumn < ActiveRecord::Migration
  def up
  	add_column :user_files, :name, :string
  end
  def down
  	remove_column :user_files, :name
  end
end
