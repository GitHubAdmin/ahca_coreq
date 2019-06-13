# , decode_compressed_response: true

require "spec_helper"

RSpec.describe AhcaCoreq::Endpoints::Private do

  describe "failures" do
    it "returns an error response with incorrect credentials" do
      VCR.use_cassette("private.upload-credential-fail", record: :none, decode_compressed_response: true) do
        c = ::AhcaCoreq::Client.new

        file = File.new("newfile",  "w+")
        expect{c.private.upload_short_stay(file)}.to raise_error(JSON::ParserError)
        FileUtils.rm_f(file)
      end
    end

    it "returns error JSON with invalid request id" do
      VCR.use_cassette("private.status-fail", record: :none, decode_compressed_response: true) do
        c = ::AhcaCoreq::Client.new

        expect(c).to receive(:requires_authentication).and_return true

        json = c.private.status("INVALID_ID")
        expect(json["responseCode"]).to eq "ERROR"
        expect(json["responseDescription"]).to eq "Invalid File Upload Request ID."
      end
    end
  end

  describe "#upload_short_stay" do
    # Uploads short-stay results
    # ::AhcaCoreq::Client.new.private.upload_short_stay(csv-file)
    it "should submit a valid file and return the response with unique file upload id" do
      VCR.use_cassette("private.upload-ss-good", record: :none, decode_compressed_response: true) do
        c = ::AhcaCoreq::Client.new

        expect(c).to receive(:requires_authentication).and_return true

        file = File.new(AhcaCoreq.root + "/../spec/files/" + "Sample_CoreQ_SS_upload.csv", "r")
        resp = c.private.upload_short_stay(file)

        expect(resp['responseCode']).to eq "PROCESSING"
        expect(resp['fileName']).to eq "Sample_CoreQ_SS_upload.csv"
      end
    end
  end

  describe "#upload_long_stay" do
    # Uploads long-stay results
    # ::AhcaCoreq::Client.new.private.upload_long_stay(csv-file)
    it "should submit a valid file and return the response with unique file upload id" do
      VCR.use_cassette("private.upload-ls-good", record: :none, decode_compressed_response: true) do
        c = ::AhcaCoreq::Client.new

        expect(c).to receive(:requires_authentication).and_return true

        file = File.new(AhcaCoreq.root + "/../spec/files/" + "Sample_CoreQ_LS_upload.csv", "r")
        resp = c.private.upload_long_stay(file)

        expect(resp['responseCode']).to eq "PROCESSING"
        expect(resp['fileName']).to eq "Sample_CoreQ_LS_upload.csv"
      end
    end
  end

  describe "#status" do
    # Checks on the status of an upload
    # ::AhcaCoreq::Client.new.private.status(request_id)
    it "should return an array with information about each row if the upload had errors" do
      VCR.use_cassette("private.status", record: :none, decode_compressed_response: true) do
        c = ::AhcaCoreq::Client.new

        expect(c).to receive(:requires_authentication).and_return true

        array = c.private.status("UbCtGLsSnVgo0qpDB_v-sQ==")
        expect(array[0][1]).to eq "Message Type"
        expect(array[1][1]).to eq "ERROR"
      end
    end

    it "should return a JSON if everything in the file was correct" do
      VCR.use_cassette("private.status", record: :none, decode_compressed_response: true) do
        c = ::AhcaCoreq::Client.new

        expect(c).to receive(:requires_authentication).and_return true

        json = c.private.status("d-CMXVFvnsnz0sS2S0r_hg==")
        expect(json["fileName"]).to eq "Sample_CoreQ_LS_upload.csv"
        expect(json["responseCode"]).to eq "SUCCESS"
      end
    end
  end


end
