module Tmdb
  class Person < Resource
    has_resource 'person', plural: 'people'

    # http://docs.themoviedb.apiary.io/#people
    @@fields = [
      :adult,
      :also_known_as,
      :biography,
      :birthday,
      :deathday,
      :homepage,
      :id,
      :known_for,
      :name,
      :place_of_birth,
      :profile_path,
      :movie_credits,
      :tv_credits,
      :combined_credits,
      :images,
      :changes
    ]

    @@fields.each do |field|
      attr_accessor field
    end

    # Get the list of popular people on The Movie Database. This list refreshes every day.
    def self.popular
      search = Tmdb::Search.new("/#{endpoints[:singular]}/popular")
      search.fetch.collect do |result|
        next unless result['known_for']
        result['known_for'] = result['known_for'].collect { |movie| Tmdb::Movie.new(movie) }
        new(result)
      end
    end

    # Get the latest person id.
    def self.latest
      search = Tmdb::Search.new("/#{endpoints[:singular]}/latest")
      person = new(search.fetch_response)
    end

    # Get the combined credits for a specific person id.
    def self.credits(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/combined_credits")
      search.fetch_response
    end

    # Get film credits for a specific person id.
    def self.movie_credits(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/movie_credits")
      search.fetch_response
    end

    # Get TV credits for a specific person id.
    def self.tv_credits(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/tv_credits")
      search.fetch_response
    end

    # Get external ID's for a specific person id.
    def self.external_ids(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/external_ids")
      search.fetch_response
    end

    # Get the images for a specific person id.
    def self.images(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/images")
      search.fetch_response
    end

    # Get the tagged images for a specific person id.
    def self.tagged_images(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/tagged_images")
      search.fetch_response
    end

    # Get the changes for a specific person id.
    # Changes are grouped by key, and ordered by date in descending order.
    # By default, only the last 24 hours of changes are returned.
    # The maximum number of days that can be returned in a single request is 14. The language is present on fields that are translatable.
    def self.changes(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/changes")
      search.fetch_response
    end
  end
end
