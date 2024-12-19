module Anthropic
  module Admin
    class WorkspaceMembers
      def initialize(client:)
        @client = client
      end

      def list(workspace_id:, **query_params)
        @client.get("/organizations/workspaces/#{workspace_id}/members", query_params)
      end

      def get(workspace_id:, user_id:)
        @client.get("/organizations/workspaces/#{workspace_id}/members/#{user_id}")
      end

      def create(workspace_id:, user_id:, workspace_role:)
        params = { user_id: user_id, workspace_role: workspace_role }
        @client.post("/organizations/workspaces/#{workspace_id}/members", params)
      end

      def update(workspace_id:, user_id:, workspace_role:)
        params = { workspace_role: workspace_role }
        @client.post("/organizations/workspaces/#{workspace_id}/members/#{user_id}", params)
      end

      def delete(workspace_id:, user_id:)
        @client.delete("/organizations/workspaces/#{workspace_id}/members/#{user_id}")
      end
    end
  end
end
