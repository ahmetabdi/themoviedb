module Tmdb
  class Search
    def initialize(resource = nil)
      @params = {}
      @resource = resource.nil? ? '/search/movie' : resource
      self
    end

    def query(query)
      @params[:query] = query.to_s
      self
    end

    def year(year)
      @params[:year] = year.to_s
      self
    end

    def primary_release_year(year)
      @params[:primary_release_year] = year.to_s
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
		  when 'multi'
		    '/search/multi'
                  when 'find'
                    '/find'
      end
      self
    end

    def filter(conditions)
      if conditions
        conditions.each do |key, value|
          if respond_to?(key)
            send(key, value)
          else
            @params[key] = value
          end
        end
      end
    end

    # Sends back main data
    def fetch
      fetch_response['results']
    end

    # Send back whole response
    def fetch_response(conditions = {})
      if conditions[:external_source]
        options = @params.merge(Api.config.merge({ external_source: conditions[:external_source] }))
      else
        options = @params.merge(Api.config)
      end
      response = Api.get(@resource, query: options)

      original_etag = response.headers.fetch('etag', '')
      etag = original_etag.delete('"')

      Api.set_response('code' => response.code, 'etag' => etag)
      response.to_hash
    end
  end
end
