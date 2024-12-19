module Anthropic
  module Admin
    class Workspaces
      def initialize(client:)
        @client = client
      end

      def list(**query_params)
        @client.get('/organizations/workspaces', query_params)
      end

      def get(workspace_id:)
        @client.get("/organizations/workspaces/#{workspace_id}")
      end

      def update(workspace_id:, name:)
        @client.post("/organizations/workspaces/#{workspace_id}", { name: name })
      end

      def create(name:)
        @client.post('/organizations/workspaces', { name: name })
      end

      def archive(workspace_id:)
        @client.post("/organizations/workspaces/#{workspace_id}/archive")
      end

      def members
        @client.workspace_members
      end
    end
  end
end
