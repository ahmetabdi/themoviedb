module Tmdb
  class Genre
    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value) if respond_to?(key.to_sym)
      end
    end

    # http://docs.themoviedb.apiary.io/#genres
    @@fields = [
      :id,
      :page,
      :total_pages,
      :total_results,
      :results
    ]

    @@fields.each do |field|
      attr_accessor field
    end

    def self.search(query)
      detail(list['genres'].detect { |g| g['name'] == query }['id'])
    end

    class << self
      alias find search
    end

    def self.list
      search = Tmdb::Search.new('/genre/list')
      search.fetch_response
    end

    def self.detail(id, conditions = {})
      url = "/genre/#{id}/movies"
      unless conditions.empty?
        url << '?'
        conditions.each_with_index do |(key, value), index|
          url << "#{key}=#{value}"
          url << '&' if index != conditions.length - 1
        end
      end
      search = Tmdb::Search.new(url)
      new(search.fetch_response)
    end

    def name
      @name ||= self.class.list['genres'].detect { |g| g['id'] == @id }['name']
    end

    def get_page(page_number, conditions = {})
      if page_number != @page && page_number > 0 && page_number <= @total_pages
        conditions[:page] = page_number
        self.class.detail(id, conditions)
      end
    end
  end
end
