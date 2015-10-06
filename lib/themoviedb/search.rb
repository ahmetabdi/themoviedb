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
      @resource = case resource
      when 'movie'
        '/search/movie'
      when 'collection'
        '/search/collection'
      when 'tv'
        '/search/tv'
      when 'person'
        '/search/person'
      when 'list'
        '/search/list'
      when 'company'
        '/search/company'
      when 'keyword'
        '/search/keyword'
      when 'find'
        '/find'
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
    def fetch
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

      response_meta = { 'code' => response.code, 'etag' => etag }

      if response.code == 429
        response_meta['retry_after'] = response.headers.fetch( 'Retry-After' ).to_i
      else
        response_meta['rate_limit'] = response.headers.fetch( 'X-RateLimit-Limit' ).to_i
        response_meta['rate_limit_remaining'] = response.headers.fetch( 'X-RateLimit-Remaining' ).to_i
        response_meta['rate_limit_reset'] = response.headers.fetch( 'X-RateLimit-Reset' ).to_i
      end

      Api.set_response( response_meta )
      return response.to_hash
    end
  end
end
