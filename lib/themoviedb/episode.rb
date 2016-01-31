module Tmdb
  class Episode < Resource
    has_resource 'episode', plural: 'episodes'

    # Get the primary information about a TV episode by combination of a season and episode number.
    def self.detail(id, season, episode, conditions = {})
      search = Tmdb::Search.new("/tv/#{endpoint_id + id.to_s}/season/#{endpoint_id + season.to_s}/#{endpoints[:singular]}/#{endpoint_id + episode.to_s}")
      search.filter(conditions)
      search.fetch_response
    end

    # Get the TV episode cast credits by combination of season and episode number.
    def self.cast(id, season, episode, _conditions = {})
      search = Tmdb::Search.new("/tv/#{endpoint_id + id.to_s}/season/#{endpoint_id + season.to_s}/#{endpoints[:singular]}/#{endpoint_id + episode.to_s}/credits")
      search.fetch_response['cast']
    end

    # Get the TV episode crew credits by combination of season and episode number.
    def self.crew(id, season, episode, _conditions = {})
      search = Tmdb::Search.new("/tv/#{endpoint_id + id.to_s}/season/#{endpoint_id + season.to_s}/#{endpoints[:singular]}/#{endpoint_id + episode.to_s}/credits")
      search.fetch_response['crew']
    end

    # Get the external ids for a TV episode by comabination of a season and episode number.
    def self.external_ids(id, season, episode, _conditions = {})
      search = Tmdb::Search.new("/tv/#{endpoint_id + id.to_s}/season/#{endpoint_id + season.to_s}/#{endpoints[:singular]}/#{endpoint_id + episode.to_s}/external_ids")
      search.fetch_response
    end

    # Get the images (episode stills) for a TV episode by combination of a season and episode number.
    def self.images(id, season, episode, _conditions = {})
      search = Tmdb::Search.new("/tv/#{endpoint_id + id.to_s}/season/#{endpoint_id + season.to_s}/#{endpoints[:singular]}/#{endpoint_id + episode.to_s}/images")
      search.fetch_response
    end
  end
end
