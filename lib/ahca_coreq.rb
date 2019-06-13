require "ahca_coreq/version"
require "ahca_coreq/configuration"
require "ahca_coreq/configurable"
require "rest-client"
require 'active_support/core_ext/hash'
require 'addressable'
require 'json'
require 'csv'

module AhcaCoreq
  extend AhcaCoreq::Configurable

  def self.root
    File.expand_path('..', __FILE__)
  end

end

require 'ahca_coreq/client'
