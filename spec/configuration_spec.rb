require "spec_helper"

RSpec.describe AhcaCoreq::Configuration do
  describe "#username" do
    it "default value is abc" do
      expect(::AhcaCoreq::Configuration.new.username).to eq "fake_username"
    end
  end

  describe "#username=" do
    it "can set value" do
      config = ::AhcaCoreq::Configuration.new
      config.username = 'xyz'
      expect(config.username).to eq('xyz')
    end
  end
end
