# This handle Movie, TV and Person for the search/multi endpoint
module MultiRepresenter
  include Representable::JSON

  # Movie
  property :adult
  property :backdrop_path
  property :genre_ids
  property :id
  property :original_language
  property :original_title
  property :overview
  property :release_date
  property :poster_path
  property :popularity
  property :title
  property :video
  property :vote_average
  property :vote_count

  # TV
  property :first_air_date
  property :original_name
  property :origin_country
  property :name

  # Person
  property :profile_path

  property :media_type

end
