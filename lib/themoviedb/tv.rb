module Tmdb
  class TV < Resource
    has_resource 'tv', plural: 'tv'

    # http://docs.themoviedb.apiary.io/#tv
    @@fields = [
      :backdrop_path,
      :created_by,
      :episode_run_time,
      :first_air_date,
      :genres,
      :homepage,
      :id,
      :in_production,
      :languages,
      :last_air_date,
      :name,
      :networks,
      :number_of_episodes,
      :number_of_seasons,
      :original_name,
      :origin_country,
      :overview,
      :popularity,
      :poster_path,
      :seasons,
      :status,
      :vote_average,
      :vote_count,
      :credits,
      :external_ids
    ]

    @@fields.each do |field|
      attr_accessor field
    end

    # Get the list of popular TV shows. This list refreshes every day.
    def self.popular
      search = Tmdb::Search.new('/tv/popular')
      search.fetch.collect { |result| new(result) }
    end

    # Get the list of top rated TV shows. By default, this list will only include TV shows that have 2 or more votes. This list refreshes every day.
    def self.top_rated
      search = Tmdb::Search.new('/tv/top_rated')
      search.fetch.collect { |result| new(result) }
    end

    # Discover TV shows by different types of data like average rating, number of votes, genres, the network they aired on and air dates
    def self.discover(conditions = {})
      search = Tmdb::Search.new('/discover/tv')
      search.filter(conditions)
      search.fetch.collect { |result| new(result) }
    end

    # Get the cast information about a TV series.
    def self.cast(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/credits")
      search.fetch_response['cast']
    end

    # Get the crew information about a TV series.
    def self.crew(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/credits")
      search.fetch_response['crew']
    end

    # Get the external ids that we have stored for a TV series.
    def self.external_ids(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/external_ids")
      search.fetch_response
    end

    # Get the images (posters and backdrops) for a TV series.
    def self.images(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/images")
      search.fetch_response
    end
  end
end
