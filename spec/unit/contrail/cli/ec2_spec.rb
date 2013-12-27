require 'spec_helper'
require 'contrail/cli'
require 'contrail/cli/ec2'

describe Contrail::CLI::EC2 do
  describe "with ec2 command" do
    describe "with no arguments" do
      it "returns ec2 application" do
        expect(described_class.command.name).to eq 'ec2'
      end
      it "exits with code 0" do
        captured_output = capture_stdout do
          expect { described_class.command.block.call(Hash.new, Array.new, described_class.command)}.to terminate.with_code 0
        end
      end
      it "returns help document for ec2" do
        captured_output = capture_stdout do
          expect { described_class.command.block.call(Hash.new, Array.new, described_class.command)}.to terminate.with_code 0
        end
        expect(captured_output.gsub(/\e\[(\d+)m/, '')).to include 'contrail ec2 <subcommand> [options]'
      end
      describe "with -h flag" do
        it "returns help dialog" do
          captured_output = capture_stdout do
            expect { described_class.command.block.call({ :help => true }, Array.new, described_class.command)}.to terminate.with_code 0
          end
          expect(captured_output.gsub(/\e\[(\d+)m/, '')).to include 'contrail ec2 <subcommand> [options]'
        end
        it "returns help dialog even if other flags are passed" do
          captured_output = capture_stdout do
            expect { described_class.command.block.call({ :help => true, :human => true }, Array.new, described_class.command)}.to terminate.with_code 0
          end
          expect(captured_output.gsub(/\e\[(\d+)m/, '')).to include 'contrail ec2 <subcommand> [options]'
        end
      end
      it "returns error code if invalid flags are passed" do
        captured_output = capture_stdout do
          expect { described_class.command.block.call({ :foobar => true }, Array.new, described_class.command)}.to terminate.without_code 0
        end
      end
    end
  end
end
