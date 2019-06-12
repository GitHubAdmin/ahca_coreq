module AhcaCoreq
  class Configuration

    attr_accessor :access_key, :secret_key, :base_uri

    def initialize
      @access_key          = ENV['ACCESS_KEY'] || "default_access_key"
      @secret_key          = ENV['SECRET_KEY'] || "default_secret_key"
      @base_uri            = 'https://api.ahca.org/'
    end

  end
end
