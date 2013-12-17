require 'spec_helper'
require 'contrail/config'

describe Contrail::Config do
  subject(:config) {
    Contrail::Config.new('util/awsconfig')
  }
  it 'sets access keys' do
    expect(config.data['aws_access_key_id']).to eq 'SAMPLEKEY'
    expect(config.data['aws_secret_access_key']).to eq 'SAMPLESECRETKEYS'
    expect(config.data['aws_default_region']).to eq 'us-west-2'
  end
end
