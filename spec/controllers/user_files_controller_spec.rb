require "spec_helper"

describe UserFilesController do
  after { FileUtils.rm_f("#{Rails.root}/public/uploads/") }
  let(:basename) { "fart.txt" }
  let(:path) { Rails.root.join("spec", "fixtures", basename) }
  let(:file_object) do
    ActionDispatch::Http::UploadedFile.new(
      {
        filename: basename,
        content_type: "text",
        tempfile: File.new(path),
      }
    )
  end

  describe "post /upload" do
    it "adds a UserFile to the database" do
      post :upload, upload_file: file_object

      UserFile.find_by(name: basename).should be_present
    end

    it "copies the given file to /public/uploads/" do
      post :upload, upload_file: file_object

      File.exists?("#{Rails.root}/public/uploads/#{basename}").should be_true
    end
  end

  describe "#get_file_by_name" do
    before { post :upload, upload_file: file_object }
    it "returns a file object containing the desired file" do
      returned_file = subject.get_file_by_name("fart.txt")
      returned_file.should be_a File
      returned_file.read.should == File.read("spec/fixtures/fart.txt")
    end
  end

  describe "get /user_files/:id" do
    it ""
  end
end
