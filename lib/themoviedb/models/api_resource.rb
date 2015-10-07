require 'representable/json'
require 'ostruct'

module Tmdb
  class ApiResource < OpenStruct
    private

    def self.build_single_resource(response, representer)
      return unless response
      new.extend(representer).from_hash(response)
    end

    def self.build_collection(response, representer)
      response.reduce([]) do |resources, res|
        resources << new.extend(representer).from_hash(res)
      end
    end

    def build_for_collection(response, representer)
      [].extend(representer.for_collection).from_hash(response)
    end
  end
end
