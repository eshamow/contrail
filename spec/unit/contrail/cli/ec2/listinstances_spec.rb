require 'spec_helper'
require 'contrail/cli'

describe Contrail::CLI::EC2::Listinstances do
  describe "when no options are passed" do
    it "calls the listinstances application" do
      expect(described_class.command.name).to eq 'listinstances'
    end
    describe "if default config file is available" do
      it "exits with code 0" do
        captured_output = capture_stdout do
          expect { described_class.command.block.call(Hash.new, Array.new, described_class.command) }.to terminate.with_code 0
        end
      end
    end
  end
  describe "when -h is passed" do
    it "returns help document" do
      captured_output = capture_stdout do
        expect { described_class.command.block.call({:help => true}, Array.new, described_class.command) }.to terminate.with_code 0
      end
      expect(captured_output.gsub(/\e\[(\d+)m/, '')).to include 'contrail ec2 listinstances <options>'
    end
    it "returns help document even if other options are passed" do
      captured_output = capture_stdout do
        expect { described_class.command.block.call({:help => true, :keyname => true}, Array.new, described_class.command) }.to terminate.with_code 0
      end
      expect(captured_output.gsub(/\e\[(\d+)m/, '')).to include 'contrail ec2 listinstances <options>'
    end
    it "exits with code 0" do
      captured_output = capture_stdout do
        expect { described_class.command.block.call({:help => true}, Array.new, described_class.command) }.to terminate.with_code 0
      end
    end
  end
  describe "when -c is passed" do
    it "loads the appropriate config file"
  end
  describe "when -c is not passed" do
    it "loads the default config file"
  end
  it "returns an error code when invalid options are passed"
  describe "when -H is passed" do
    it "returns tabulated data"
  end
  describe "when -H is not passed" do
    it "returns a JSON hash of data"
  end
end
