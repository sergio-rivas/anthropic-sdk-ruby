# frozen_string_literal: true

module Anthropic
  class Batches
    def initialize(client:)
      @client = client
    end

    def list
      @client.get('/messages/batches')
    end

    def create(requests:)
      @client.post('/messages/batches', { requests: requests })
    end

    def retrieve(message_batch_id:)
      @client.get("/messages/batches/#{message_batch_id}")
    end

    def results(message_batch_id:)
      @client.get("/messages/batches/#{message_batch_id}/results")
    end

    def cancel(message_batch_id:)
      @client.post("/messages/batches/#{message_batch_id}/cancel", {})
    end
  end
end
