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
  end
end
