require "spec_helper"

RSpec.describe AhcaCoreq::Configuration do
  describe "#access_key" do
    it "default value is abc" do
      expect(::AhcaCoreq::Configuration.new.access_key).to eq "default_access_key"
    end
  end

  describe "#access_key=" do
    it "can set value" do
      config = ::AhcaCoreq::Configuration.new
      config.access_key = 'xyz'
      expect(config.access_key).to eq('xyz')
    end
  end
end
