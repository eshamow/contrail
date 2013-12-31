require 'contrail/cli'
require 'contrail/cli/ec2'
require 'contrail/ec2'

require 'cri'
require 'json'

module Contrail::CLI::EC2
  module Deleteinstances
    def self.command
      @cmd ||= Cri::Command.define do
        name 'deleteinstances'
        usage 'deleteinstances <options>'
        summary 'delete EC2 instances'

        run do |opts, args, cmd|
          if opts[:help]
            puts cmd.help
            exit 0
          end

          configfile = opts[:configfile] || '~/.awsconfig'
          result = Contrail::EC2.new(
            Contrail::Config.new(configfile).data
          ).delete_servers(args)
          if opts[:human]
            printf "%-15s%-60s\n", 'ID', 'Status'
            result.each do |server|
              printf "%-15s%-60s\n", server[0], server[1] == true ? 'destroyed' : server[1]
            end
          else
            puts result.to_json
          end
          exit 0
        end
      end
    end
  end

  self.command.add_command(Deleteinstances.command)
end
