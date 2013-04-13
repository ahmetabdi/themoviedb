module Tmdb
  class Api
    include HTTParty
    base_uri 'http://api.themoviedb.org/3/'
    format :json
    headers 'Accept' => 'application/json'

    def self.config
      @@config
    end

    def self.key(api_key)
      @@config = { :api_key => api_key }
    end

  end
end