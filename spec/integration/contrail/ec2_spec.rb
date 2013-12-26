require 'spec_helper'
require 'contrail/ec2'

#  filter specs are all commented out until Fog mocking makes more sense

describe Contrail::EC2 do
  subject(:client) {
    Fog.mock!
    Contrail::EC2.new(Contrail::Config.new('util/awsconfig').data)
  }
  before(:each) do
    client.connection.key_pairs.new(
      :name => 'contrail_testkey',
      :fingerprint => 'f00200bar'
    ).save
  end
  after(:each) do
    client.connection.key_pairs.destroy 'contrail_testkey'
  end
#  it 'can filter keys by name' do
#    expect(client.get_keys(:name => 'contrail_testkey').count).to eq 1
#    expect(client.get_keys(:name => 'contrail_fakekey').count).to eq 0
#  end
#  it 'can filter images by id' do
#    expect(client.get_images(:id => 'ari-fefe73ce').count).to eq 1
#    expect(client.get_images(:id => 'foo').count).to eq 0
#  end
#  it 'can filter servers by id' do
#    expect(client.get_servers(:id => 'i-8c67ecbb').count).to eq 1
#    expect(client.get_servers(:id => 'fakenum').count).to eq 0
#  end
#  it 'can filter servers by private ip' do
#    expect(client.get_servers(:id => 'i-8c67ecbb').count).to eq 1
#    expect(client.get_servers(:id => 'fakenum').count).to eq 0
#  end
#  it 'can filter servers by public ip' do
#    expect(client.get_servers(:public_ip_address => '54.218.204.120').count).to eq 1
#    expect(client.get_servers(:public_ip_address => 'fakenum').count).to eq 0
#  end
#  it 'can filter servers by dns name' do
#    expect(client.get_servers(:dns_name => 'ec2-54-218-204-120.us-west-2.compute.amazonaws.com').count).to eq 1
#    expect(client.get_servers(:dns_name => 'fakenum').count).to eq 0
#  end
#  it 'can filter servers by image id' do
#    expect(client.get_servers(:image_id => 'ami-e030a5d0').count).to eq 1
#    expect(client.get_servers(:image_id => 'fakenum').count).to eq 0
#  end
#  it 'can filter servers by key name' do
#    expect(client.get_servers(:key_name => 'nil').count).to eq 1
#    expect(client.get_servers(:key_name => 'fakenum').count).to eq 0
#  end
#  it 'can filter servers by a single security group' do
#    expect(client.get_servers(:security_groups => ['sg-d21d90e2']).count).to eq 1
#    expect(client.get_servers(:security_groups => ['fake']).count).to eq 0
#  end
#  it 'can filter servers by multiple security groups'
#  it 'can filter servers by multiple indexes'
end
