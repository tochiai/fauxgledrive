class UserFile < ActiveRecord::Base
  validates :local_path, presence: true
  validates :name, presence: true
  validate :file_exists, if: :local_path

  def self.from_path(file_path)
    new(
      local_path: file_path,
      name: Pathname.new(file_path).basename.to_s,
    )
  end

  private
  def file_exists
    errors.add(:local_path, "File does not exist") unless File.exists?(local_path)
  end
end
