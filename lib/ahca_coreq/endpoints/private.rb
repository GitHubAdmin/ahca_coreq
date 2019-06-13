module AhcaCoreq
  module Endpoints
    class Private < Base

      # Request:
      #   Parameters (method: POST)
      #     file (required) : <sample_coreq_ss_upload.csv>
      # Response:
      #   {
      #     "fileUploadRequestId": "UbCtGLsSnVgo0qpDB_v-sQ==",
      #     "fileName": "Sample_CoreQ_SS_upload.csv",
      #     "responseCode": "PROCESSING",
      #     "responseDescription": "File upload is processing. Check the status via  File Upload Status Check API call."
      #   }
      def upload_short_stay(file)
        resp = sfilepost("upload-coreq", 'COREQ_SS', file)
        JSON.parse(resp)
      end

      # Request:
      #   Parameters (method: POST)
      #     file (required) : <sample_coreq_ls_upload.csv>
      # Response:
      #   {
      #     "fileUploadRequestId": "d-CMXVFvnsnz0sS2S0r_hg==",
      #     "fileName": "Sample_CoreQ_LS_upload.csv",
      #     "responseCode": "PROCESSING",
      #     "responseDescription": "File upload is processing. Check the status via  File Upload Status Check API call."
      #   }
      def upload_long_stay(file)
        resp = sfilepost("upload-coreq", 'COREQ_LS', file)
        JSON.parse(resp)
      end

      # Request:
      #   Parameters (method: POST)
      #     request_id (required) : UbCtGLsSnVgo0qpDB_v-sQ==
      # Response: (with invalid upload data)
      # <CSV> [
      #   ["Line Number","Message Type","Message"],
      #   ["1","ERROR","Line Number 1: The value '000001' in ""Medicare Provider Number"" does not match a value in the system. Please confirm the value and re-upload the file. If the value you entered is correct but generates this error, please contact help@ltctrendtracker.com for assistance."],
      #   ["2","ERROR","Line Number 2: The value '000002' in ""Medicare Provider Number"" does not match a value in the system. Please confirm the value and re-upload the file. If the value you entered is correct but generates this error, please contact help@ltctrendtracker.com for assistance."]
      # ]
      # Response: (with valid upload data)
      #   {
      #     "fileUploadRequestId": "d-CMXVFvnsnz0sS2S0r_hg==",
      #     "fileName": "Sample_CoreQ_LS_upload.csv",
      #     "responseCode": "SUCCESS",
      #     "responseDescription": "File uploaded successfully."
      #   }
      def status(rid)
        resp = sget("status", {"FileUploadRequestId" => rid})
        begin
          # valid request id returns CSV of data about the upload
          CSV.parse(resp.body)

        rescue CSV::MalformedCSVError
          # Invalid request id returns JSON error
          JSON.parse(resp.body)

        end
      end

    end
  end
end
