
require "spec_helper"

RSpec.describe AhcaCoreq do

  it "has a version number" do
    expect(AhcaCoreq::VERSION).not_to be nil
  end

  before :each do
    AhcaCoreq.configure do |config|
      config.username = 'xyz'
    end
  end

  it "is configured to use the given username" do
    client = AhcaCoreq::Client.new

    expect(client.config.username).to eq('xyz')
  end

  after :each do
    AhcaCoreq.reset_config
  end
end
