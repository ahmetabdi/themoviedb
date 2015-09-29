require 'require_all'
require_all 'lib'

module Tmdb
  def self.connect(api_key)
    Tmdb::Configuration::Api.instance.tap do |api|
      api.connect(api_key)
    end
  end
end
