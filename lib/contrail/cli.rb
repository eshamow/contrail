require 'contrail'
require 'contrail/version'

require 'cri'

module Contrail::CLI
  def self.command
    @cmd ||= Cri::Command.define do
      name        'contrail'
      usage       'contrail <subcommand> [options]'
      summary     'Simple multi-vendor cloud management'
      description <<-EOD
        Simple tool for performing basic operations across multiple cloud
        vendors.
      EOD

      flag :h, :help, 'show help for this command'
      flag :t, :trace, 'display stack traces on application crash'

      run do |opts, args, cmd|
        puts cmd.help
        exit 0
      end
    end
  end
end

require 'contrail/cli/version'
