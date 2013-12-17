require 'spec_helper'
require 'contrail/cli'

describe Contrail::CLI::Version do
  describe "with --version flag" do
    it "returns contrail version" do
      cmd = described_class.command
      expect(cmd.name).to eq 'version'
    end
  end
end
