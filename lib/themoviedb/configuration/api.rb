require 'singleton'

module Tmdb
  class Configuration
    class Api
      include Singleton

      attr_reader :base_url, :version
      attr_accessor :api_key, :language

      def initialize
        @base_url = 'https://api.themoviedb.org/3/'.freeze
        @version = 3
        @language = 'en'
      end

      def url_for(action, params = {})
        params[:api_key] = api_key
        params[:language] = language
        url = URI.join(base_url, action)
        url.query = URI.encode_www_form(params) if params
        url.to_s
      end
    end
  end
end
