module Tmdb
  class Discover
    def initialize(resource=nil)
      @params = {}
      @resource = resource.nil? ? '/discover/movie' : resource
      self
    end

    def primary_release_year(year)
      @params[:primary_release_year] = "#{year}"
      self
    end

    def include_adult(include_adult)
      @params[:include_adult] = include_adult
      self
    end

    def first_air_date_year(year)
      @params["first_air_date_year"] = "#{year}"
      self
    end

    def page(page)
      @params[:page] = "#{page}"
      self
    end

    def resource(resource)
      if resource == 'movie' then
        @resource = '/discover/movie'
      elsif resource == 'tv' then
        @resource = '/discover/tv'
      end
      self
    end

    #Sends back main data
    def fetch()
      fetch_response['results']
    end

    #Send back whole response
    def fetch_response(conditions={})
      if conditions[:external_source]
        options = @params.merge(Api.config.merge({external_source: conditions[:external_source]}))
      else
        options = @params.merge(Api.config)
      end
      response = Api.get(@resource, :query => options)

      original_etag = response.headers.fetch('etag', '')
      etag = original_etag.gsub(/"/, '')

      Api.set_response({'code' => response.code, 'etag' => etag})
      response.to_hash
    end
  end
end
