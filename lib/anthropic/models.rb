# frozen_string_literal: true

module Anthropic
  class Models
    def initialize(client:)
      @client = client
    end

    def list
      @client.get '/models'
    end

    def get(model_id:)
      @client.get "/models/#{model_id}"
    end
  end
end
