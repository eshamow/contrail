require 'contrail/cli'
require 'contrail/cli/ec2'
require 'contrail/ec2'

require 'cri'

module Contrail::CLI::EC2
  module Listinstances
    def self.command
      @cmd ||= Cri::Command.define do
        name 'listinstances'
        usage 'listinstances <options>'
        summary 'list EC2 instances'

        client_options = Hash.new

        option :i, :id, 'Search for instance with id', :argument => :required do
          |value|
          client_options[:id] = value
        end
        option :p, :privateip, 'Search for instance with private IP address',
          :argument => :required do |value|
          client_options[:private_ip_address] = value
        end
        option :u, :publicip, 'Search for instance with public IP address',
          :argument => :required do |value|
          client_options[:public_ip_address] = value
        end
        option :d, :dnsname, 'Search for instance with public DNS name',
          :argument => :required do |value|
          client_options[:dns_name] = value
        end
        option :g, :imageid, 'Search for instance by image ID',
          :argument => :required do |value|
          client_options[:image_id] = value
        end
        option :k, :keyname, 'Search for instance by key name',
          :argument => :required do |value|
          client_options[:key_name] = value
        end
        option :s, :securitygroups,
          'Search for instance by security group membership',
          :argument => :required do |value|
          client_options[:security_groups] = value
        end

        run do |opts, args, cmd|
          if opts[:help]
            puts cmd.help
            exit 0
          end

          configfile = opts[:configfile] || '~/.awsconfig'
          client = Contrail::EC2.new(
            Contrail::Config.new(configfile).data
          ).get_servers(client_options).to_json

          fields = ['ID', 'private_ip_address', 'public_ip_address', 'dns_name', 'image_id', 'key_name', 'security_groups']

          if opts[:human]
            printf "%-15s%-20s%-20s%-60s%-15s%-60s\n", *fields
            JSON.parse(client).each do |c|
              printf "%-15s%-20s%-20s%-60s%-15s%-60s\n", c['id'],
                c['private_ip_address'], c['public_ip_address'], c['dns_name'],
                c['image_id'], c['key_name'], c['security_groups']
            end
          else
            puts client
          end
          exit 0
        end
      end
    end
  end

  self.command.add_command(Listinstances.command)
end
