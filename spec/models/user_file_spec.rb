require "spec_helper"

describe UserFile do
  let(:basename) { "fart.txt" }
  let(:local_path) { Rails.root.join("spec", "fixtures", basename) }
  let(:file) { File.open(local_path) }

  describe "validations" do
    subject { described_class.new(params) }

    context "without local path" do
      let(:params) { {name: "butt"} }

      it "is invalid" do
        subject.should_not be_valid
      end

      it "gets errors" do
        subject.should have(1).error_on(:local_path)
      end
    end

    context "without name" do
      let(:params) { {local_path: "/buuty/buuty"} }

      it "requires name" do
        subject.should_not be_valid
      end

      it "gets errors" do
        subject.should have(1).error_on(:name)
      end
    end

    context "without valid file in local path" do
      let(:params) { {local_path: "/not_real/butt", name: "buuty"} }

      it "requires a real-ass file to be at the end of that path, fool" do
        subject.should_not be_valid
      end

      it "gets errors" do
        subject.should have(1).error_on(:local_path)
      end
    end

    context "when things are right and chill" do
      let(:params) { {local_path: "/dev/null", name: "buuty"} }
      it "is valid" do
        subject.should be_valid
      end
    end
  end

  describe "self.from_path" do
    subject { UserFile.from_path(local_path) }

    its(:local_path) { should == local_path }
    its(:name) { should == basename }
  end
end
