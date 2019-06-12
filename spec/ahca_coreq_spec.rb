
require "spec_helper"

RSpec.describe AhcaCoreq do

  it "has a version number" do
    expect(AhcaCoreq::VERSION).not_to be nil
  end

  before :each do
    AhcaCoreq.configure do |config|
      config.access_key = 'xyz'
    end
  end

  it "is configured to use the given access_key" do
    client = AhcaCoreq::Client.new

    expect(client.config.access_key).to eq('xyz')
  end

  after :each do
    AhcaCoreq.reset_config
  end
end
