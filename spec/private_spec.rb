# , decode_compressed_response: true

require "spec_helper"

RSpec.describe AhcaCoreq::Endpoints::Private do

  # describe "#status" do
  #   # Checks the status of a submitted upload
  #   # ::AhcaCoreq::Client.new.private.status(uniq_key)
  #   it "should return the status of a previous upload" do
  #     VCR.use_cassette("private.status", record: :none) do
  #       c = ::AhcaCoreq::Client.new

  #       expect(c).to receive(:requires_api_keys).and_return true
  #       allow_any_instance_of(::AhcaCoreq::Endpoints::Private).to receive(:calc_tonce).and_return(1535059663168)
  #       allow_any_instance_of(::AhcaCoreq::Endpoints::Private).to receive(:generate_signature).and_return("mysignature")

  #       cur = c.private.status('ABC')
  #       expect(cur).to eq 200

  #     end
  #   end
  # end


end
