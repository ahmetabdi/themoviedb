module Tmdb
  class Api
    include HTTParty
    base_uri 'http://api.themoviedb.org/3/'
    format :json
    headers 'Accept' => 'application/json'

    def self.config
      @@config ||= {}
    end

    def self.key(api_key)
      self.config[:api_key] = api_key
    end

    def self.language(lang)
      if (lang.nil?)
        self.config.delete(:language)
      else
        self.config[:language] = lang
      end
    end

  end
end
