module Tmdb
  class Keyword < Resource
    has_resource 'keyword', plural: 'keywords'

    # http://docs.themoviedb.apiary.io/#keywords
    @@fields = [
      :id,
      :name
    ]

    @@fields.each do |field|
      attr_accessor field
    end

    def self.movies(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/movies")
      search.fetch.collect { |result| Tmdb::Movie.new(result) }
    end
  end
end
