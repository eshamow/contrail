require 'spec_helper'
require 'contrail/cli'
require 'contrail/cli/ec2'

describe Contrail::CLI::EC2 do
  describe "with ec2 command" do
    describe "when no options are passed" do
      it "returns help syntax" do
        cmd = described_class.command
        expect(cmd.name).to eq 'ec2'
      end
    end
  end
end
