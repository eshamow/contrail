require 'spec_helper'
require 'contrail/version'

describe Contrail do
  describe "interacting with the version" do
    it "can get the version" do
      expect(described_class.version).to be_a_kind_of String
    end

    it "cannot change the version" do
      expect do
        described_class.version = "notaversion"
      end.to raise_error(NoMethodError, /undefined method `version='/)
    end
  end
end
