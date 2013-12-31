# NEEDS TESTS!!!!
require 'contrail'
require 'fog'

module Contrail
  class EC2
    attr_reader :connection

    def initialize(configdata)
      @connection = Fog::Compute.new(
        :provider => 'aws',
        :region   => configdata['aws_default_region']
      )
    end
    def get_keys(options = {:name => nil})
      @connection.key_pairs.select do |key_pair|
        next unless (options[:name] == nil) || (key_pair.name == options[:name])
        key_pair
      end
    end
    def get_images(options = {:id => nil})
      @connection.images.select do |image|
        next unless (options[:id] == nil) || (image.id == options[:id])
        image
      end
    end

    DEFAULT_SERVER_OPTIONS = {
      :id => nil,
      :private_ip_address => nil,
      :public_ip_address => nil,
      :dns_name => nil,
      :image_id => nil,
      :key_name => nil,
      :security_group_ids => nil,
      :state => nil,
    }

    def get_servers(options = DEFAULT_SERVER_OPTIONS)
      @connection.servers.select do |server|
        ((options[:id] == nil || server.id == options[:id]) &&
                     (options[:private_ip_address] == nil || server.private_ip_address == options[:private_ip_address]) &&
                     (options[:public_ip_address] == nil || server.public_ip_address == options[:public_ip_address]) &&
                     (options[:dns_name] == nil || server.dns_name == options[:dns_name]) &&
                     (options[:image_id] == nil || server.image_id == options[:image_id]) &&
                     (options[:key_name] == nil || server.key_name == options[:key_name]) &&
                     (options[:security_groups] == nil || server.security_groups == options[:security_groups]) &&
                     (options[:state] == nil || server.state == options[:state])
        )
      end
    end
    def delete_servers(server_array)
      result_array = Hash.new
      server_array.each do |server|
        begin
          result_array[server] = @connection.servers.destroy(server)
        rescue Fog::Compute::AWS::NotFound, Fog::Compute::AWS::Error => e
          result_array[server] = e
        end
      end
      result_array
    end
  end
end
