module Tmdb
  class InvalidApiKeyError < StandardError ;  end
  class Api
    include HTTParty
    base_uri 'api.themoviedb.org/3/'
    format :json
    headers 'Accept' => 'application/json'
    headers 'Content-Type' => 'application/json'

    def self.config
      @@config ||= {}
    end

    def self.key(api_key)
      config[:api_key] = api_key
    end

    def self.language(lang)
      if lang.nil?
        config.delete(:language)
      else
        config[:language] = lang
      end
    end

    def self.etag(etag)
      headers 'If-None-Match' => '"' + etag + '"'
    end

    def self.response
      @@response ||= {}
    end

    def self.set_response(hash)
      @@response = hash
      # Detect 401 Unauthorized error, which indicates invalid API key
      raise Tmdb::InvalidApiKeyError if hash['code'].to_i == 401
    end
  end
end
