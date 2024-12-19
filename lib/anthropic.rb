# frozen_string_literal: true

require_relative 'anthropic/version'
require_relative 'anthropic/configuration'
require_relative 'anthropic/http_client'
require_relative 'anthropic/client'
require_relative 'anthropic/message'
require_relative 'anthropic/message_batch'
require_relative 'anthropic/model'

module Anthropic
  class Error < StandardError; end
end
