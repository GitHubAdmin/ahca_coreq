module AhcaCoreq
  class Configuration

    attr_accessor :username, :password, :base_uri

    def initialize
      @username = ENV['USERNAME'] || "fake_username"
      @password = ENV['PASSWORD'] || "fake_password"
      @base_uri = 'https://ltctt.ahcancal.org/api/'
    end

  end
end
