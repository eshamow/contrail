require 'spec_helper'
require 'contrail/ec2'

describe Contrail::EC2 do
  it 'initiates a new EC2 client connection' do
    expect(Contrail::EC2.new(Contrail::Config.new('util/awsconfig').data).aws_instance).to be_a_kind_of AWS::EC2::Client
  end
end
