ruby_project_files = Dir[File.join(File.dirname(__FILE__), '**', '*.rb')]

require ::AhcaCoreq.root+"/ahca_coreq/endpoints/base.rb"
ruby_project_files.sort_by!{ |file_name| file_name.downcase }.each do |path|
  require_relative path
end

module AhcaCoreq
  class Client

    def initialize(params = {})
      set_config(params)
    end

    def config
      @config ||= ::AhcaCoreq.config.dup
    end

    def public(options = {})
      ::AhcaCoreq::Endpoints::Public.new(config, options)
    end

    def private(options = {})
      requires_api_keys
      ::AhcaCoreq::Endpoints::Private.new(config, options)
    end

    private

    def requires_api_keys
      return unless api_keys_missing?

      fail AhcaCoreq::MissingApiKeys, 'This feature requires API credentials.'
    end

    def api_keys_missing?
      !(config.access_key && config.secret_key)
    end

    def set_config(params)
      params.each { |k, v| config.send("#{k}=", v) }
    end

  end
end
