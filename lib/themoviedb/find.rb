module Tmdb
  class Find < Resource
    has_resource 'find'

    def self.imdb_id(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}")
      search.fetch_response(external_source: 'imdb_id')
    end

    def self.freebase_mid(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}")
      search.fetch_response(external_source: 'freebase_mid')
    end

    def self.freebase_id(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}")
      search.fetch_response(external_source: 'freebase_id')
    end

    def self.tvrage_id(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}")
      search.fetch_response(external_source: 'tvrage_id')
    end

    def self.tvdb_id(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}")
      search.fetch_response(external_source: 'tvdb_id')
    end
  end
end
