class Tmdb::Search < Tmdb::ApiResource

  def self.multi(query)
    build_collection(Tmdb::Requester.get("search/multi", query: CGI::escape(query))['results'], MultiRepresenter)
  end

end
