require 'rest_client'

module Tmdb
  class Requester
    class << self
      def get(action, params = {})
        url = api.url_for(action, params)
        perform_request do
          parse_response(RestClient.get(url, headers))
        end
      end

      def post(action, params = {}, form_data = {})
        url = api.url_for(action, params)
        perform_request do
          parse_response(RestClient.post(url, form_data.to_json, headers))
        end
      end

      def delete(action)
        url = api.url_for(action)
        perform_request do
          parse_response(RestClient.post(url, {}, headers))
        end
      end

      private

      def api
        Tmdb::Configuration::Api.instance
      end

      def perform_request(&block)
        begin
          block.call
        rescue RestClient::Exception => e
          puts Tmdb::Exception::Api.new(e.message)
        end
      end

      def headers
        {}.tap do |headers|
          headers['Accept'] = 'application/json'
          headers['Content-Type'] = 'application/json'
        end
      end

      def parse_response(response_body)
        begin
          JSON.parse(response_body)
        rescue JSON::ParserError => e
          Tmdb::Exception::JsonParseError.new("Response body could not be parsed: #{e.message}")
        end
      end
    end
  end
end
