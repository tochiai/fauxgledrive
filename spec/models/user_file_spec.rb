require "spec_helper"

describe UserFile do
	let(:basename) { "fart.txt" }
	let(:local_path) { Rails.root.join("spec", "fixtures", basename) }
	let(:file) { File.open(local_path) }

	describe "self.from_path" do
		subject { UserFile.from_path(local_path) }

		its(:local_path) { should == local_path }
		its(:name) { should == basename }
	end
end
