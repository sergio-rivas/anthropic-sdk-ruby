module Anthropic
  module Admin
    class Users
      def initialize(client:)
        @client = client
      end

      def list(**query_params)
        @client.get('/organizations/users', query_params)
      end

      def get(user_id:)
        @client.get("/organizations/users/#{user_id}")
      end

      def update(user_id:, role:)
        @client.post("/organizations/users/#{user_id}", { role: role })
      end

      def remove(user_id:)
        @client.delete("/organizations/users/#{user_id}")
      end
    end
  end
end
