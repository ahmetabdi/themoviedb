module Tmdb
  class Api
    include HTTParty
    base_uri 'http://private-ad2b-themoviedb.apiary.io/3/'
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