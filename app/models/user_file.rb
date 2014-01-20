class UserFile < ActiveRecord::Base
	def self.from_path(file_path)
		new(
			local_path: file_path,
			name: Pathname.new(file_path).basename.to_s,
		)
	end
end