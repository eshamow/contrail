require 'contrail/cli'
require 'contrail/config'

require 'cri'

module Contrail::CLI
  module EC2
    def self.command
      @cmd ||= Cri::Command.define do
        name 'ec2'
        usage 'ec2 <subcommand> [options]'
        summary 'Run commands against EC2 computing environment'

        option :c,
          :configfile,
          'Use specified config file (default is ~/.awsconfig)',
          :argument => :required

        option :T,
          :displaytags,
          'Display instance tags'

        run do |opts, args, cmd|
          puts cmd.help
          exit 0
        end
      end
    end
  end

  self.command.add_command(EC2.command)
end

require 'contrail/cli/ec2/listinstances'
require 'contrail/cli/ec2/deleteinstances'
