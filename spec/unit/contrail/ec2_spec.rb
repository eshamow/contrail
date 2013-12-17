require 'spec_helper'
require 'contrail/ec2'

describe Contrail::EC2 do
  subject(:client) {
    Fog.mock!
    Contrail::EC2.new(Contrail::Config.new('util/awsconfig').data)
  }
  it 'initiates a new Fog EC2 connection' do
    expect(client.connection).to be_a_kind_of Fog::Compute::AWS::Mock
  end
end
