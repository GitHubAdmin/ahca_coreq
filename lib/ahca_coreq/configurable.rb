module AhcaCoreq
  module Configurable

    def config
      @config ||= ::AhcaCoreq::Configuration.new
    end

    def configure
      yield config if block_given?
    end

    def reset_config
      @config = Configuration.new
    end

  end
end
