module Tmdb
  class Collection < Resource
    has_resource 'collection', plural: 'collections'

    # http://docs.themoviedb.apiary.io/#collections
    @@fields = [
      :backdrop_path,
      :id,
      :name,
      :parts,
      :poster_path
    ]

    @@fields.each do |field|
      attr_accessor field
    end

    # Get all of the images for a particular collection by collection id.
    def self.images(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/images")
      search.fetch_response
    end
  end
end
