module Tmdb
  # Movie resource
  class Movie < Tmdb::ApiResource
    # Get the basic movie information for a specific movie id.
    def self.find(id, opts = { append: [] })
      build_single_resource(
        Tmdb::Requester.get("movie/#{id}",
                            append_to_response: opts[:append]),
        MovieRepresenter
      )
    end

    # Get the latest movie id.
    def self.latest
      build_single_resource(
        Tmdb::Requester.get('movie/latest'),
        MovieRepresenter
      )
    end

    # Get the list of movies playing that have been released this week.
    def self.now_playing(opts = { page: 1 })
      build_collection(
        Tmdb::Requester.get('movie/now_playing',
                            page: opts[:page])['results'],
        MovieRepresenter
      )
    end

    # Get the list of popular movies.
    def self.popular(opts = { page: 1 })
      build_collection(
        Tmdb::Requester.get('movie/popular',
                            page: opts[:page])['results'],
        MovieRepresenter
      )
    end

    # Get the list of top rated movies.
    def self.top_rated(opts = { page: 1 })
      build_collection(
        Tmdb::Requester.get('movie/top_rated',
                            page: opts[:page])['results'],
        MovieRepresenter
      )
    end

    # Get the list of upcoming movies by release date.
    def self.upcoming(opts = { page: 1 })
      build_collection(
        Tmdb::Requester.get('movie/upcoming',
                            page: opts[:page])['results'],
        MovieRepresenter
      )
    end

    # Get the alternative titles for a specific movie id.
    def self.alternative_titles(opts = { country: '', append: [] })
      build_collection(
        Tmdb::Requester.get("movie/#{id}/alternative_titles",
                            country: opts[:country],
                            append_to_response: opts[:append]),
        MovieRepresenter
      )
    end

    # Get the cast and crew information for a specific movie id.
    def self.credits(opts = { append: [] })
      build_collection(
        Tmdb::Requester.get("movie/#{id}/credits",
                            append_to_response: opts[:append]),
        MovieRepresenter
      )
    end

    # Get the images (posters and backdrops) for a specific movie id.
    def self.images(opts = { language: api.language, append: [], include_image_language: "" })
      Tmdb::Requester.get("movie/#{id}/images",
                          language: opts[:language],
                          append_to_response: opts[:append],
                          include_image_language: opts[:include_image_language])
    end

    # Get the plot keywords for a specific movie id.
    def self.keywords(opts = { append: [] })
    end

    # Get the release date and certification information by country for a specific movie id.
    def self.releases(opts = { append: [] })
    end

    # Get the videos (trailers, teasers, clips) for a specific movie id.
    def self.videos(opts = { language: api.language, append: [] })
    end

    # Get the translations for a specific movie id.
    def self.translations(opts = { append: [] })
    end

    # Get the similar movies for a specific movie id.
    def self.similar(opts = { page: 1, language: api.language, append: [] })
    end

    # Get the reviews for a particular movie id
    def self.reviews(opts = { page: 1, language: api.language, append: [] })
    end

    # Get the lists that the movie belongs to.
    def self.lists(opts = { page: 1, language: api.language, append: [] })
    end

    # Get the changes for a specific movie id.
    def self.changes(start_date = Time.now.at_beginning_of_year.to_s("%Y-%m-%d"), end_date = Time.now.at_end_of_year.to_s("%Y-%m-%d"))
    end

    # Create rating on a movie.
    def self.add_rating(value, opts = { session_id: api.session_id, guest_session_id: api.guest_session_id })
    end

    # Delete rating on a movie.
    def self.remove_rating(opts = { session_id: api.session_id, guest_session_id: api.guest_session_id })
    end

  end
end
