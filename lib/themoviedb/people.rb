module Tmdb
  class People < Resource
    has_resource 'person', :plural => 'persons'

    #http://docs.themoviedb.apiary.io/#people
    @@fields = [
      :adult,
      :also_known_as,
      :biography,
      :birthday,
      :deathday,
      :homepage,
      :id,
      :name,
      :place_of_birth,
      :profile_path
    ]
    
    @@fields.each do |field|
      attr_accessor field
    end

    #Get the list of popular people on The Movie Database. This list refreshes every day.
    def self.popular
      search = Tmdb::Search.new("/people/popular")
      search.fetch
    end

    #Get the latest person id.
    def self.latest
      search = Tmdb::Search.new("/people/latest")
      search.fetch_response
    end

    #Get the credits for a specific person id.
    def self.credits(id, conditions={})
      search = Tmdb::Search.new("/#{self.endpoints[:singular]}/#{self.endpoint_id + id.to_s}/credits")
      search.fetch_response
    end

    #Get the images for a specific person id.
    def self.images(id, conditions={})
      search = Tmdb::Search.new("/#{self.endpoints[:singular]}/#{self.endpoint_id + id.to_s}/images")
      search.fetch_response
    end

    #Get the changes for a specific person id.
    #Changes are grouped by key, and ordered by date in descending order. 
    #By default, only the last 24 hours of changes are returned. 
    #The maximum number of days that can be returned in a single request is 14. The language is present on fields that are translatable.
    def self.changes(id, conditions={})
      search = Tmdb::Search.new("/#{self.endpoints[:singular]}/#{self.endpoint_id + id.to_s}/changes")
      search.fetch_response
    end

  end
end