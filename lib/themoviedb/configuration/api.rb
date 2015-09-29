require 'singleton'

module Tmdb::Configuration
  class Api
    include Singleton

    attr_reader :base_url, :version, :api_key

    def initialize
      self.base_url = "https://api.themoviedb.org/3/".freeze
      self.version = 3.freeze
    end

    def connect(api_key)
      @api_key = api_key
    end

    def url_for(action, params={})
      params[:api_key] = api_key
      url = URI.join(base_url, action)
      url.query = URI.encode_www_form(params) if params
      url.to_s
    end

    private
      attr_writer :base_url, :api_key, :version
  end
end
