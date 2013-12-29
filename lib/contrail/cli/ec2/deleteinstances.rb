require 'contrail/cli'
require 'contrail/cli/ec2'
require 'contrail/ec2'

require 'cri'

module Contrail::CLI::EC2
  module Deleteinstances
    def self.command
      @cmd ||= Cri::Command.define do
        name 'deleteinstances'
        usage 'deleteinstances <options>'
        summary 'delete EC2 instances'

        client_options = Hash.new

        run do |opts, args, cmd|
          if opts[:help]
            puts cmd.help
            exit 0
          end

          configfile = opts[:configfile] || '~/.awsconfig'
          client = Contrail::EC2.new(
            Contrail::Config.new(configfile).data
          ).get_servers(client_options).to_json
#          if opts[:human]
#            printf "%-15s%-20s%-20s%-60s%-15s%-60s\n", 'ID',
#              'private_ip_address', 'public_ip_address', 'dns_name', 'image_id',
#              'key_name', 'security_groups'
#            JSON.parse(client).each do |c|
#              printf "%-15s%-20s%-20s%-60s%-15s%-60s\n", c['id'],
#                c['private_ip_address'], c['public_ip_address'], c['dns_name'],
#                c['image_id'], c['key_name'], c['security_groups']
#            end
#          else
#            puts client
#          end
          exit 0
        end
      end
    end
  end

  self.command.add_command(Deleteinstances.command)
end
