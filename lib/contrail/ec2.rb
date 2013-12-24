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
    def get_servers(options = {
      :id => nil,
      :private_ip_address => nil,
      :public_ip_address => nil,
      :dns_name => nil,
      :image_id => nil,
      :key_name => nil,
      :security_group_ids => nil,
    })
      require 'pp'
      puts options
      @connection.servers.select do |server|
        next unless (options[:id] == nil) || (server.id == options[:id])
        next unless (options[:private_ip_address] == nil) || (server.id == options[:private_ip_address])
        next unless (options[:public_ip_address] == nil) || (server.id == options[:public_ip_address])
        next unless (options[:dns_name] == nil) || (server.id == options[:dns_name])
        next unless (options[:image_id] == nil) || (server.id == options[:image_id])
        next unless (options[:key_name] == nil) || (server.id == options[:key_name])
        next unless (options[:security_groups] == nil) || (server.id == options[:security_groups])
        server
      end
    end
  end
end
