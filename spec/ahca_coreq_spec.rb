
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

  # example you can call to verify gem really works
  # 1. turn off VCR in spec_helper
  # 2. set config values (DON'T COMMIT)
  # 3. rspec spec/ahca_coreq_spec.rb:30
  it "can establish connections", skip: true do
    client = AhcaCoreq::Client.new
    client.config.username = "SET THIS"
    client.config.password = "SET THIS"

    file = File.new(AhcaCoreq.root + "/../spec/files/" + "Sample_CoreQ_SS_upload.csv", "r")
    resp = client.private.upload_short_stay(file)

    expect(resp['responseCode']).to eq "PROCESSING"
    expect(resp['fileName']).to eq "Sample_CoreQ_SS_upload.csv"
  end

end
