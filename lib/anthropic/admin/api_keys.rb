module Anthropic
  module Admin
    class ApiKeys
      def initialize(client:)
        @client = client
      end

      def list(**query_params)
        @client.get('/organizations/api_keys', query_params)
      end

      def get(api_key_id:)
        @client.get("/organizations/api_keys/#{api_key_id}")
      end

      def update(api_key_id:, params: {})
        @client.post("/organizations/api_keys/#{api_key_id}", params)
      end
    end
  end
end
