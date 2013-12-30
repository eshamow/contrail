require 'spec_helper'
require 'contrail/ec2'

describe Contrail::EC2 do
  subject(:client) {
    Fog.mock!
    Contrail::EC2.new(Contrail::Config.new('util/awsconfig').data)
  }
  it 'creates a new Contrail::EC2 object when initialized' do
    expect(client).to be_a_kind_of Contrail::EC2
  end
  it 'initiates a new Fog EC2 connection' do
    expect(client.connection).to be_a_kind_of Fog::Compute::AWS::Mock
  end
  it 'can list all available keys' do
    expect(client.get_keys).to be_a_kind_of Fog::Compute::AWS::KeyPairs
  end
  it 'can list all available images' do
    expect(client.get_images).to be_a_kind_of Fog::Compute::AWS::Images
  end
  it 'can list all servers' do
    expect(client.get_servers).to be_a_kind_of Fog::Compute::AWS::Servers
  end
  describe 'when deleting servers' do
    it 'returns an array'
    describe 'when returning an array' do
      it 'has one key for every server passed'
      it 'has one result for every key'
    end
  end
end
