module Anthropic
  class Client
    include Anthropic::HttpClient
    attr_reader *%i[api_key api_base_url api_version anthropic_version]

    def initialize
      @api_key           = Anthropic.configuration.send(:api_key)
      @api_base_url      = Anthropic.configuration.send(:api_base_url)
      @api_version       = Anthropic.configuration.send(:api_version)
      @anthropic_version = Anthropic.configuration.send(:anthropic_version)
    end

    def messages
      Messages.new(client: self)
    end

    def message_batches
      Batches.new(client: self)
    end

    def models
      Models.new(client: self)
    end
  end
end
