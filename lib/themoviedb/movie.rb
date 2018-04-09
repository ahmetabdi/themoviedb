module Tmdb
  class Movie < Resource
    has_resource 'movie', plural: 'movies'

    # http://docs.themoviedb.apiary.io/#movies
    @@fields = [
      :adult,
      :backdrop_path,
      :belongs_to_collection,
      :budget,
      :genres,
      :homepage,
      :id,
      :imdb_id,
      :original_language,
      :original_title,
      :overview,
      :popularity,
      :poster_path,
      :production_companies,
      :production_countries,
      :release_date,
      :revenue,
      :runtime,
      :spoken_languages,
      :status,
      :tagline,
      :title,
      :vote_average,
      :vote_count,
      :alternative_titles,
      :credits,
      :images,
      :keywords,
      :releases,
      :trailers,
      :translations,
      :reviews,
      :lists,
      :changes
    ]

    @@fields.each do |field|
      attr_accessor field
    end

    # Get the latest movie id. singular
    def self.latest
      search = Tmdb::Search.new('/movie/latest')
      new(search.fetch_response)
    end

    # Get the list of upcoming movies. This list refreshes every day. The maximum number of items this list will include is 100.
    def self.upcoming
      search = Tmdb::Search.new('/movie/upcoming')
      search.fetch.collect { |result| new(result) }
    end

    # Get the list of movies playing in theatres. This list refreshes every day. The maximum number of items this list will include is 100.
    def self.now_playing
      search = Tmdb::Search.new('/movie/now_playing')
      search.fetch.collect { |result| new(result) }
    end

    # Get the list of popular movies on The Movie Database. This list refreshes every day.
    def self.popular
      search = Tmdb::Search.new('/movie/popular')
      search.fetch.collect { |result| new(result) }
    end

    # Get the list of top rated movies. By default, this list will only include movies that have 10 or more votes. This list refreshes every day.
    def self.top_rated
      search = Tmdb::Search.new('/movie/top_rated')
      search.fetch.collect { |result| new(result) }
    end

    # Discover movies by different types of data like average rating, number of votes, genres and certifications.
    def self.discover(conditions = {})
      search = Tmdb::Search.new('/discover/movie')
      search.filter(conditions)
      search.fetch.collect { |result| new(result) }
    end

    # Get the alternative titles for a specific movie id.
    def self.alternative_titles(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/alternative_titles")
      search.fetch_response
    end

    # Get the cast information for a specific movie id.
    def self.casts(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/casts")
      search.fetch_response['cast']
    end

    # Get the cast information for a specific movie id.
    def self.crew(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/casts")
      search.fetch_response['crew']
    end

    # Get the images (posters and backdrops) for a specific movie id.
    def self.images(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/images")
      search.fetch_response
    end

    # Get the plot keywords for a specific movie id.
    def self.keywords(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/keywords")
      search.fetch_response
    end

    # Get the release date by country for a specific movie id.
    def self.releases(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/releases")
      search.fetch_response
    end

    # Get the trailers for a specific movie id.
    def self.trailers(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/trailers")
      search.fetch_response
    end

    # Get the translations for a specific movie id.
    def self.translations(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/translations")
      search.fetch_response
    end

    # Get the similar movies for a specific movie id.
    def self.similar_movies(id, conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/similar_movies")
      search.filter(conditions)
      search.fetch.collect { |result| new(result) }
    end

    # Get the lists that the movie belongs to.
    def self.lists(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/lists")
      search.fetch_response
    end

    # Get the changes for a specific movie id.
    # Changes are grouped by key, and ordered by date in descending order.
    # By default, only the last 24 hours of changes are returned.
    # The maximum number of days that can be returned in a single request is 14.
    # The language is present on fields that are translatable.
    def self.changes(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/changes")
      search.fetch_response
    end

    # Get the credits for a specific movie id.
    def self.credits(id, _conditions = {})
      search = Tmdb::Search.new("/#{endpoints[:singular]}/#{endpoint_id + id.to_s}/credits")
      search.fetch_response
    end
  end
end
