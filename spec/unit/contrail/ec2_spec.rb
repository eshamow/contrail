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

  #tag_to_hash
  describe 'when consuming a string containing a comma-separated list of key value pairs' do
    tagarray = String.new
    before(:each) do
      tagarray = 'foo=bar,baz=tmp,a=b'
    end
    it 'returns a hash containing all of the keys and values' do
      taghash = client.tag_to_hash(tagarray)
      taghash.keys.should have(3).items
      taghash.keys.should =~ ['baz','foo','a']
      taghash.values.should have(3).items
      taghash.values.should =~ ['bar','tmp','b']
    end
  end

  #deleteinstances
  describe 'when deleting servers' do
    it 'returns a hash' do
      server = client.connection.servers.create
      expect(client.delete_servers([server.id])).to be_a_kind_of Hash
    end
    it 'returns a un-truthy value if server is not present' do
      #note: this will return a Fog::Compute::AWS::Error reading "Malformed => Invalid id" if mocking is off
      expect(client.delete_servers(['foo'])['foo'].message).to match /The instance ID .*foo.* does not exist/
    end
    describe 'when returning an array' do
      describe 'when all servers are valid' do
        instances = Array.new
        before(:each) do
          3.times do |i|
            instances << client.connection.servers.create.id
          end
        end
        after(:each) do
          instances.each do |instance|
            client.connection.servers.destroy(instance)
          end
          instances = Array.new
        end
        it 'has one key for every server passed' do
          expect(client.delete_servers(instances).length).to eq 3
        end
        it 'has one true result for every key' do
          expect(client.delete_servers(instances).keys).to match_array instances
        end
      end
      describe 'when only some servers are valid' do
        instances = Array.new
        before(:each) do
          2.times do |i|
            instances << client.connection.servers.create.id
          end
          instances << 'foo'
          instances << client.connection.servers.create.id
        end
        after(:each) do
          instances.each do |instance|
            begin
              client.connection.servers.destroy(instance)
            rescue Fog::Compute::AWS::NotFound => e
              next
            end
          end
          instances = Array.new
        end
        it 'has one key for every server passed' do
          expect(client.delete_servers(instances).length).to eq 4
        end
        it 'has one boolean result for every valid key' do
          valid_results = client.delete_servers(instances).select do |key, value|
            value == true
          end
          expect(valid_results.length).to eq 3
        end
        it 'has one error message for every invalid key' do
          valid_results = client.delete_servers(instances).select do |key, value|
            value.class == Fog::Compute::AWS::NotFound
          end
        end
      end
    end
  end

  #createinstances
  #
end
