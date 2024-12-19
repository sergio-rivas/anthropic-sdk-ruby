# frozen_string_literal: true

module Anthropic
  class Configuration
    CONFIG_KEYS = %i[api_base_url api_version anthropic_version api_key admin_api_key].freeze
    attr_accessor *CONFIG_KEYS

    ANTHROPIC_VERSION  = '2023-06-01'
    ANTHROPIC_BASE_URL = 'https://api.anthropic.com/'
    API_VERSION        = 'v1'
    REQUEST_TIMEOUT    = 120
    LOG_ERRORS         = false

    def initialize
      @api_base_url       = ANTHROPIC_BASE_URL
      @api_version        = API_VERSION
      @anthropic_version  = ANTHROPIC_VERSION
      @api_key            = nil
      @admin_api_key      = nil
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Anthropic::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
