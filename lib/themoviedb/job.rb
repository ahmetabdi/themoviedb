module Tmdb
  class Job
    def initialize(attributes={})
      attributes.each do |key, value|
        if self.respond_to?(key.to_sym)
          self.instance_variable_set("@#{key}", value)
        end
      end
    end

    #http://docs.themoviedb.apiary.io/#jobs
    @@fields = [
      :name,
      :department
    ]

    @@fields.each do |field|
      attr_accessor field
    end

    def self.list
      search = Tmdb::Search.new("/job/list")
      search.fetch_response
    end

    def get_page(page_number, conditions={})
      if page_number != @page and page_number > 0 and page_number <= @total_pages
        conditions.merge!({ :page => page_number })
        self.class.detail(id, conditions)
      end
    end
  end
end
