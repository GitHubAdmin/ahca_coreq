module AhcaCoreq
  module Endpoints
    class Base

      attr_accessor :config, :options

      def initialize(config, options = {})
        @config  = config
        @options = options
      end

      def get(endpoint, params = {})
        url = geturl(endpoint, params)
        begin
          RestClient.get(url)
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
      end

      def sget(endpoint, params = {})
        params[:access_key] = @config.access_key
        params[:tonce]      = calc_tonce
        params[:signature]  = generate_signature('GET', endpoint, params)

        url = geturl(endpoint, params)
        begin
          RestClient.get(url)
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
      end

      def post(endpoint, params = {})
        params[:access_key] = @config.access_key
        params[:tonce]      = calc_tonce
        params[:signature]  = generate_signature('POST', endpoint, params)

        url = posturl(endpoint)
        data = Addressable::URI.form_encode(params)
        begin
          RestClient.post(url, params, headers)
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
      end

      private

      def calc_tonce
        @ct ||= DateTime.now.strftime('%Q')
      end

      def posturl(endpoint)
        @config.base_uri + commonuri + endpoint
      end

      def geturl(endpoint, params)
        url = @config.base_uri + commonuri + endpoint
        if ! params.blank?
          url += "?" + Addressable::URI.form_encode(params)
        end
        url
      end

      def generate_signature(verb, endpoint, params)
        pd = payload(verb, endpoint, params)
        OpenSSL::HMAC.hexdigest('sha256', @config.secret_key, pd)
      end

      def payload(verb, endpoint, params)
        ordered_params = params.sort_by{|k,v| k }.to_h
        qry = Addressable::URI.form_encode(ordered_params)
        "#{calc_tonce}#{verb}#{endpoint}#{JSON.dump(qry)}"
      end

      def commonuri
        "/v1/"
      end

      def headers
        {
          "Content-Type" => "application/json",
          'ACCESS-KEY': @config.access_key,
          'ACCESS-TIMESTAMP': calc_tonce,
          'ACCESS-SIGN': sign,
        }
      end

    end
  end
end