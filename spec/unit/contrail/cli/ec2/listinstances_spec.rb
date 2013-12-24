require 'spec_helper'
require 'contrail/cli'

describe Contrail::CLI::EC2::Listinstances do
  describe "with EC2 Listinstances command" do
    describe "when no options are passed" do
      it "returns help syntax" do
        cmd = described_class.command
        expect(cmd.name).to eq 'listinstances'
      end
    end
  end
end
