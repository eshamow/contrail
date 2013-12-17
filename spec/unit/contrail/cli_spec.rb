require 'spec_helper'
require 'contrail/cli'

describe Contrail::CLI do
  describe "with no arguments" do
    it "returns help syntax" do
      cmd = described_class.command
      expect(cmd.name).to eq 'contrail'
    end
  end
end
