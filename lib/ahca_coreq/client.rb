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
      requires_authentication
      ::AhcaCoreq::Endpoints::Private.new(config, options)
    end

    private

    def requires_authentication
      return unless auth_credentials_missing?

      fail AhcaCoreq::MissingAuthCredentials, 'This feature requires API credentials.'
    end

    def auth_credentials_missing?
      !(config.username && config.password)
    end

    def set_config(params)
      params.each { |k, v| config.send("#{k}=", v) }
    end

  end
end
