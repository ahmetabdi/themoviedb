require 'test/unit'

class MovieTest < Test::Unit::TestCase
  def setup
   @movie = Tmdb::Movie.detail(22855)
  end

  def test_case_1
    assert_equal 22855, @movie.id, "Should return a valid id"
  end

  def test_case_2
    assert_equal "tt1398941", @movie.imdb_id, "Should return a valid imdb_id"
  end

  def test_case_3
  	assert_equal 67, @movie.runtime, "Should return runtime"
  end

  def test_case_4
  	assert_equal "/mXuqM7ksHW1AJ30AInwJvJTAwut.jpg", @movie.backdrop_path, "Should return backdrop_path"
  end

end