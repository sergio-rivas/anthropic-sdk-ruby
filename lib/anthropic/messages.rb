# frozen_string_literal: true

module Anthropic
  class Messages
    DEFAULT_MODEL = 'claude-3-5-sonnet-20241022'

    def initialize(client:)
      @client = client
    end

    def create(messages:, model: DEFAULT_MODEL, max_tokens: 1024, extra_params: {})
      body = { model: model, max_tokens: max_tokens, messages: messages }.merge(extra_params)
      @client.post('/messages', body)
    end

    def count_tokens(messages:, model: DEFAULT_MODEL, extra_params: {})
      body = { model: model, messages: messages }.merge(extra_params)
      @client.post('/messages/count_tokens', body)
    end

    def batches
      @client.message_batches
    end
  end
end
