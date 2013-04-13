module Tmdb 
  class Configuration
    def initialize()
      @params = {}
      @resource = '/configuration'
      self
    end

    # To build an image URL, you will need 3 pieces of data. 
    # The base_url, size and file_path. 
    # Simply combine them all and you will have a fully qualified URL. Here’s an example URL:
    # http://cf2.imgobject.com/t/p/w500/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg
    def base_url
      fetch_response['images']['base_url']
    end

    # HTTPS
    def secure_base_url
      fetch_response['images']['secure_base_url']
    end

    def poster_sizes
      fetch_response['images']['poster_sizes']
    end

    def backdrop_sizes
      fetch_response['images']['backdrop_sizes']
    end

    def profile_sizes
      fetch_response['images']['profile_sizes']
    end

    def logo_sizes
      fetch_response['images']['logo_sizes']
    end

    def fetch_response
      options = @params.merge(Api.config)
      response = Api.get(@resource, :query => options)
      response.to_hash
    end
  end
end