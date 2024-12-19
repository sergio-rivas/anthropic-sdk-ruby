# frozen_string_literal: true

require 'event_stream_parser'
require 'net/http'
require 'json'
require 'uri'

module Anthropic
  module HttpClient
    def get(path, query_params = {}, headers = {})
      request(:get, path, query_params, nil, headers)
    end

    def post(path, body = nil, headers = {})
      request(:post, path, {}, body, headers)
    end

    def put(path, body = nil, headers = {})
      request(:put, path, {}, body, headers)
    end

    def delete(path, headers = {})
      request(:delete, path, {}, nil, headers)
    end

    def options(path, headers = {})
      request(:options, path, {}, nil, headers)
    end

    def head(path, headers = {})
      request(:head, path, {}, nil, headers)
    end

    def stream_request(path, body = nil, headers = {}, &block)
      uri = build_uri(path)
      full_headers = merge_headers(headers)

      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        request = create_request(:post, uri.path, body, full_headers)

        http.request(request) do |response|
          raise "HTTP Error: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

          parser = EventStreamParser::Parser.new
          response.read_body do |chunk|
            parser.feed(chunk) do |event|
              yield event if block_given?
            end
          end
        end
      end
    end

    private

    def request(method, path, query_params = {}, body = nil, headers = {})
      uri = build_uri(path, query_params)
      full_headers = merge_headers(headers)

      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        request = create_request(method, uri.request_uri, body, full_headers)
        response = http.request(request)

        parse_response(response)
      end
    end

    def build_uri(path, query_params = {})
      print(self)
      full_path = "/#{@api_version}#{path}"
      uri = URI("#{@api_base_url}#{full_path}")
      uri.query = URI.encode_www_form(query_params) unless query_params.empty?
      uri
    end

    def merge_headers(custom_headers)
      {
        'anthropic-version' => @anthropic_version,
        'x-api-key' => @api_key,
        'content-type' => 'application/json'
      }.merge(custom_headers)
    end

    def request_class(method)
      case method
      when :get     then Net::HTTP::Get
      when :post    then Net::HTTP::Post
      when :put     then Net::HTTP::Put
      when :delete  then Net::HTTP::Delete
      when :options then Net::HTTP::Options
      when :head    then Net::HTTP::Head
      else raise ArgumentError, "Unsupported HTTP method: #{method}"
      end
    end

    def create_request(method, path, body = nil, headers = {})
      request_klass = request_class(method)

      request = request_klass.new(path)
      headers.each { |key, value| request[key] = value }

      if body
        request.body = body.is_a?(String) ? body : body.to_json
      end

      request
    end

    def parse_response(response)
      case response
      when Net::HTTPSuccess
        response.body.empty? ? nil : JSON.parse(response.body)
      when Net::HTTPClientError, Net::HTTPServerError
        raise "HTTP Error: #{response.code} - #{response.body}"
      else
        response
      end
    end
  end
end
