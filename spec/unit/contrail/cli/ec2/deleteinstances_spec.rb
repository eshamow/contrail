require 'spec_helper'
require 'contrail/cli'

describe Contrail::CLI::EC2::Deleteinstances do
  describe "when no options are passed" do
    it "calls the deleteinstances application" do
      expect(described_class.command.name).to eq 'deleteinstances'
    end
    describe "if default config file is available" do
      it "exits with code 0" do
        captured_output = capture_stdout do
          expect { described_class.command.block.call(Hash.new, Array.new, described_class.command) }.to terminate.with_code 0
        end
      end
    end
    describe "when -h is passed" do
      it "returns help document" do
        captured_output = capture_stdout do
          expect { described_class.command.block.call({:help => true}, Array.new, described_class.command) }.to terminate.with_code 0
        end
        expect(captured_output.gsub(/\e\[(\d+)m/, '')).to include 'contrail ec2 deleteinstances <options>'
      end
    end
    it "returns help document even if other options are passed" do
      captured_output = capture_stdout do
        expect { described_class.command.block.call({:help => true, :human => true}, Array.new, described_class.command) }.to terminate.with_code 0
      end
      expect(captured_output.gsub(/\e\[(\d+)m/, '')).to include 'contrail ec2 deleteinstances <options>'
  end
    it "exits with code 0" do
      captured_output = capture_stdout do
        expect { described_class.command.block.call({:help => true}, Array.new, described_class.command) }.to terminate.with_code 0
      end
    end
    it "returns an error code when invalid options are passed" do
      captured_output = capture_stdout do
        expect { described_class.command.block.call({:foobar => true}, Array.new, described_class.command) }.to terminate.without_code 0
      end
    end
  end
  describe "when -H is passed" do
    it "returns tabulated data"
  end
  describe "when -H is not passed" do
    it "returns a JSON hash of data"
  end
  describe "when a single ID is passed" do
    it "returns a single response"
  end
  describe "when multiple IDs are passed" do
    it "returns an identical number of responses"
  end
end
