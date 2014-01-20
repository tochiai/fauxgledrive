class AddLocalPathToUserFile < ActiveRecord::Migration
  def change
  	add_column :user_files, :local_path, :string
  end
end
