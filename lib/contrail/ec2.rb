require 'contrail'
require 'aws'

module Contrail
  class EC2
    attr_accessor :aws_instance

    def initialize(configdata)
      AWS.config(
        access_key_id: configdata['aws_access_key_id'],
        secret_access_key: configdata['aws_secret_access_key'],
        region: configdata['aws_default_region']
      )
      @aws_instance = AWS.ec2.client
    end
  end
end
