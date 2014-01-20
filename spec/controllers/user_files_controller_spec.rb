require "spec_helper"

describe UserFilesController do
	before { FileUtils.mkdir("/tmp/fauxgle_drive") }
	after { FileUtils.rm_rf("/tmp/fauxgle_drive") }

	describe "#save_file" do
		let(:basename) { "fart.txt" }
		let(:path) { Rails.root.join("spec", "fixtures", basename) }
		let(:file_object) { File.open(path) }

		it "adds a UserFile to the database" do
			subject.save_file(file_object)

			UserFile.find_by(name: basename).should be_present
		end

		it "copies the given file to /tmp/fauxgle_drive/" do
			subject.save_file(file_object)

			File.exists?("/tmp/fauxgle_drive/#{basename}").should be_true
		end
	end

	describe "#get_file_by_name" do
		before { subject.save_file(File.open("spec/fixtures/fart.txt")) }
		it "returns a file object containing the desired file" do
			returned_file = subject.get_file_by_name("fart.txt")
			returned_file.should be_a File
			returned_file.read.should == File.read("spec/fixtures/fart.txt")
		end
	end
end

#change to solo branch