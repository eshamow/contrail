require 'spec_helper'
require 'contrail/cli'

describe Contrail::CLI do
  describe "with no arguments" do
    before(:all) do
      silence_output
    end
    after(:all) do
      enable_output
    end
    it "returns top-level application" do
      expect(described_class.command.name).to eq 'contrail'
    end
    it "exits with code 0 when called with no arguments" do
      expect { described_class.command.block.call(Hash.new, Array.new, described_class.command)}.to terminate.with_code 0
    end
    it "returns help document for contrail"
  end
  describe "with -h flag" do
    it "returns help dialog"
    it "returns help dialog even if other flags are passed"
  end
end
