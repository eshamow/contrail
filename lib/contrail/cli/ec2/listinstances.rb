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
        option :a, :imageid, 'Search for instance by image ID',
          :argument => :required do |value|
          client_options[:image_id] = value
        end
        option :k, :keyname, 'Search for instance by key name',
          :argument => :required do |value|
          client_options[:key_name] = value
        end
        option :g, :securitygroups,
          'Search for instance by security group membership',
          :argument => :required do |value|
          client_options[:security_groups] = value
        end
        option :s, :state,
          'Search for instance by state',
          :argument => :required do |value|
          client_options[:state] = value
        end
        option :t, :tags,
          'Search for instance by tags',
          :argument => :required do |value|
          client_options[:tags] = value
        end
        option :T, :displaytags,
          'Display instance tags'

        run do |opts, args, cmd|
          if opts[:help]
            puts cmd.help
            exit 0
          end

          configfile = opts[:configfile] || '~/.awsconfig'
          client = Contrail::EC2.new(
            Contrail::Config.new(configfile).data
          ).get_servers(client_options).to_json

          fields = ['ID', 'state', 'private_ip_address', 'public_ip_address', 'dns_name', 'image_id', 'key_name', 'security_groups']
          if opts[:displaytags]
            fields << 'tags'
          end

          if opts[:human]
            header_array = []
            header_array << "%-15.15s"  # ID
            header_array << "%-10.10s"  # state
            header_array << "%-20.20s"  # private_ip_address
            header_array << "%-20.20s"  # public_ip_address
            header_array << "%-60.60s"  # dns_name
            header_array << "%-15.15s"  # image_id
            header_array << "%-10.10s"  # key_name
            header_array << "%-30.30s"  # security_groups
            header_array << "%-20.20s" if opts[:displaytags]
            header_array << "\n"
            header = header_array.join
            printf header, *fields
            JSON.parse(client).each do |c|
              attribs = [c['id'],
                         c['state'],
                         c['private_ip_address'],
                         c['public_ip_address'],
                         c['dns_name'],
                         c['image_id'],
                         c['key_name'],
                         c['groups']
                       ]
              if opts[:displaytags]
                attribs << (c['tags'].keys.count > 0 ? c['tags'] : '')
              end
              begin
                printf header, *attribs
              rescue Exception => e
                require 'pry'
                binding.pry
              end

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
