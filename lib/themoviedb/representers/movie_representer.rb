module MovieRepresenter
  include Representable::JSON

  property :adult
  property :backdrop_path
  property :genres
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
  property :belongs_to_collection
  property :budget
  property :genres
  # "genres": [
  #   {
  #     "id": 18,
  #     "name": "Drama"
  #   }
  # ]
  property :homepage
  property :imdb_id
  property :production_companies
  # "production_companies": [
  #   {
  #     "name": "20th Century Fox",
  #     "id": 25
  #   },
  #   {
  #     "name": "Fox 2000 Pictures",
  #     "id": 711
  #   },
  #   {
  #     "name": "Regency Enterprises",
  #     "id": 508
  #   }
  # ],
  property :production_countries
  # "production_countries": [
  #   {
  #     "iso_3166_1": "DE",
  #     "name": "Germany"
  #   },
  #   {
  #     "iso_3166_1": "US",
  #     "name": "United States of America"
  #   }
  # ],
  property :revenue
  property :runtime
  property :spoken_languages
  # "spoken_languages": [
  #   {
  #     "iso_639_1": "en",
  #     "name": "English"
  #   }
  # ],
  property :status
  property :tagline
end
