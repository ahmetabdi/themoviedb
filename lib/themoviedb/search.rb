module Tmdb
  class Search
    def initialize(resource=nil)
      @params = {}
      @resource = resource.nil? ? '/search/movie' : resource
      self
    end

    def query(query)
      @params[:query] = "#{query}"
      self
    end

    def year(year)
      @params[:year] = "#{year}"
      self
    end

    def primary_realease_year(year)
      @params[:primary_release_year] = "#{year}"
      self
    end

    def resource(resource)
      if resource == 'movie' then
        @resource = '/search/movie'
      elsif resource == 'collection' then
        @resource = '/search/collection'
      elsif resource == 'tv' then
        @resource = '/search/tv'
      elsif resource == 'person' then
        @resource = '/search/person'
      elsif resource == 'list' then
        @resource = '/search/list'
      elsif resource == 'company' then
        @resource = '/search/company'
      elsif resource == 'keyword' then
        @resource = '/search/keyword'
      elsif resource == 'find'
        @resource = '/find'
      end
      self
    end

    def filter(conditions)
      if conditions
        conditions.each do |key, value|
          if self.respond_to?(key)
            self.send(key, value)
          else
            @params[key] = value
          end
        end
      end
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

      etag = response.headers['etag'].gsub /"/, ''
      Api.set_response({'code' => response.code, 'etag' => etag})
      response.to_hash
    end
  end
end