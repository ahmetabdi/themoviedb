module Tmdb
  class Resource
    @@endpoints = {}
    @@endpoint_id = {}

    def self.has_resource(singular = nil, opts = {})
      @@endpoints[name.downcase] = {
        singular: singular.nil? ? name.downcase.to_s : singular,
        plural: opts[:plural].nil? ? "#{name.downcase}s" : opts[:plural]
      }
      @@endpoint_id[name.downcase] = opts[:id].nil? ? '' : "#{opts[:id]}-"
    end

    def self.endpoints
      @@endpoints[name.downcase]
    end

    def self.endpoint_id
      @@endpoint_id[name.downcase]
    end

    # Get the basic resource information for a specific id.
    def self.detail(id, conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}")
      search.filter(conditions)
      search.fetch_response
    end

    def self.list(conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:plural]}")
      search.filter(conditions)
      search.fetch.collect do |result|
        new(result)
      end
    end

    def self.search(query)
      search = Tmdb::Search.new
      search.resource(endpoints[:singular].to_s)
      search.query(query)
      search.fetch.collect do |result|
        new(result)
      end
    end

    class << self
      alias find search
    end

    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value) if respond_to?(key.to_sym)
      end
    end
  end
end
