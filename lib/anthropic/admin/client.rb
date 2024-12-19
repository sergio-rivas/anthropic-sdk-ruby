module Anthropic
  module Admin
    class Client
      include Anthropic::HttpClient
      attr_reader *%i[api_key api_base_url api_version anthropic_version]

      def initialize
        @api_key           = Anthropic.configuration.send(:admin_api_key)
        @api_base_url      = Anthropic.configuration.send(:api_base_url)
        @api_version       = Anthropic.configuration.send(:api_version)
        @anthropic_version = Anthropic.configuration.send(:anthropic_version)
      end

      def users
        Users.new(client: self)
      end

      def invites
        Invites.new(client: self)
      end

      def workspaces
        Workspaces.new(client: self)
      end

      def workspace_members
        WorkspaceMembers.new(client: self)
      end

      def api_keys
        ApiKeys.new(client: self)
      end
    end
  end
end
