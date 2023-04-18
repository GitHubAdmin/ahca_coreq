module AhcaCoreq
  module Endpoints
    class Base

      attr_accessor :config, :options

      def initialize(config, options = {})
        @config  = config
        @options = options
      end

      # authenticated get
      def sget(endpoint, params = {})
        url = geturl(endpoint, params)
        begin
          client = RestClient::Resource.new(
            url,
            headers: headers,
            verify_ssl: false
          )
          client.get()
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
      end

      # authenticated post
      def sfilepost(endpoint, type, file)
        url = posturl(endpoint)
        begin
          client = RestClient::Resource.new(
            url,
            headers: headers,
            verify_ssl: false
          )
          client.post(payload(type, file))

        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
      end

      private

      def headers
        {
          authorization: 'Basic ' + Base64.encode64("#{@config.username}:#{@config.password}").chomp,
        }
      end

      def payload(type, file)
        {
          multipart: true,
          file: file,
          file_upload_type: type
        }
      end

      def geturl(endpoint, params)
        url = @config.base_uri + endpoint
        if ! params.blank?
          url += "?" + Addressable::URI.form_encode(params)
        end
        url
      end

      def posturl(endpoint)
        @config.base_uri + endpoint
      end

    end
  end
end