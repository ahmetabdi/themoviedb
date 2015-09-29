class Tmdb::Movie < Tmdb::ApiResource

  def self.find(id)
    build_single_resource(Tmdb::Requester.get("movie/#{id}"), MovieRepresenter)
  end

  def self.latest
    build_single_resource(Tmdb::Requester.get("movie/latest"), MovieRepresenter)
  end

  def self.now_playing
    build_collection(Tmdb::Requester.get("movie/now_playing")['results'], MovieRepresenter)
  end

  def self.popular
    build_collection(Tmdb::Requester.get("movie/popular")['results'], MovieRepresenter)
  end

  def self.top_rated
    build_collection(Tmdb::Requester.get("movie/top_rated")['results'], MovieRepresenter)
  end

  def self.upcoming
    build_collection(Tmdb::Requester.get("movie/upcoming")['results'], MovieRepresenter)
  end

end
