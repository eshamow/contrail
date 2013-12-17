require 'contrail/cli'
require 'contrail/version'

require 'cri'

module Contrail::CLI
  module Version
    def self.command
      @cmd ||= Cri::Command.define do
        name 'version'
        usage 'version'
        summary 'print the contrail version number'

        run do |opts, args, cmd|
          puts Contrail::VERSION
          exit 0
        end
      end
    end
  end

  self.command.add_command(Version.command)
end
