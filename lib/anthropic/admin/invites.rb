module Anthropic
  module Admin
    class Invites
      def initialize(client:)
        @client = client
      end

      def list(**query_params)
        @client.get('/organizations/invites', query_params)
      end

      def get(invite_id:)
        @client.get("/organizations/invites/#{invite_id}")
      end

      def create(invite_id:, email:, role:)
        @client.post("/organizations/invites/#{invite_id}", { email: email, role: role })
      end

      def remove(invite_id:)
        @client.delete("/organizations/invites/#{invite_id}")
      end
    end
  end
end
