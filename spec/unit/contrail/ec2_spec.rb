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
    it 'returns a hash if the server is present' do
      server = client.connection.servers.create
      expect(client.delete_servers([server.id])).to be_a_kind_of Hash
    end
    it 'throws a fog error if the server is not present' do
      expect { client.delete_servers ['foo'] }.to raise_error Fog::Compute::AWS::NotFound
    end
    describe 'when returning an array' do
      describe 'when all servers are valid' do
        instances = Hash.new
        before(:each) do
          3.times do |i|
            instances[i] = client.connection.servers.create
          end
        end
        after(:each) do
          instances.each do |instance|
            client.connection.servers.destroy(instance[1].id)
          end
        end
        it 'has one key for every server passed'
        it 'has one result for every key'
      end
      describe 'when only some servers are valid' do
        it 'has one key for every valid server passed'
        it 'has one result for every key'
      end
    end
  end
end
