## Information

### themoviedb [![Code Climate](https://codeclimate.com/github/ahmetabdi/themoviedb/badges/gpa.svg)](https://codeclimate.com/github/ahmetabdi/themoviedb) [![Gem Version](https://badge.fury.io/rb/themoviedb.png)](http://badge.fury.io/rb/themoviedb)

A Ruby wrapper for the [The Movie Database API](http://docs.themoviedb.apiary.io/).

`Ruby >= 1.9.3`

Provides a simple, easy to use interface for the Movie Database API.

Get your API key [here](https://www.themoviedb.org/account).

## Getting started

```bash
$ gem install themoviedb
```

Example usage of the 'themovedb' gem

http://themoviedb.herokuapp.com/

https://github.com/ahmetabdi/themoviedb-example

## Configuration

```ruby
Tmdb::Api.key("KEY_HERE")
```

You can change the language for the returned data with this:

```ruby
Tmdb::Api.language("de")
```

The default language is english.
The API supports translations just be aware that it does not fall back to English in the event that a field hasn't been translated.

## Resources

Current available resources:
* [Company](#company)
* [Movie](#movie)
* [TV](#tv)
* [TV Seasons](#season)
* [TV Episodes](#episode)
* [Collection](#collection)
* [Person](#person)
* [Genre](#genre)
* [Job](#job)
* [Find](#find)

Missing resources:
* Account
* Authentication
* Changes
* Collections
* Credits
* Discover
* Keywords
* Lists
* Networks
* Reviews

## Example

```ruby
Tmdb::Movie.find("batman")
Tmdb::TV.find("fringe")
Tmdb::Collection.find("spiderman")
Tmdb::Person.find("samuel jackson")
Tmdb::Company.find("lucas")
Tmdb::Genre.find("drama")
```

## Search

### Usage

resources => person, movie, tv, collection, company

```ruby
@search = Tmdb::Search.new
@search.resource('person') # determines type of resource
@search.query('samuel jackson') # the query to search against
@search.fetch # makes request
```

## Find

The supported external sources for each object are as follows:
Movies: imdb_id
People: imdb_id, freebase_mid, freebase_id, tvrage_id
TV Series: imdb_id, freebase_mid, freebase_id, tvdb_id, tvrage_id

```ruby
Tmdb::Find.imdb_id('id')
Tmdb::Find.freebase_mid('id')
Tmdb::Find.freebase_id('id')
Tmdb::Find.tvrage_id('id')
Tmdb::Find.tvdb_id('id')
```

The responses are in the hash with movie_results, person_results and tv_results


## Configuration

Get the system wide configuration information. Some elements of the API require some knowledge of this configuration data. The purpose of this is to try and keep the actual API responses as light as possible.
This method currently holds the data relevant to building image URLs as well as the change key map.
To build an image URL, you will need 3 pieces of data. The base_url, size and file_path. Simply combine them all and you will have a fully qualified URL.
Here’s an example URL: http://cf2.imgobject.com/t/p/w500/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg

```ruby
configuration = Tmdb::Configuration.new
configuration.base_url
configuration.secure_base_url
configuration.poster_sizes
configuration.backdrop_sizes
configuration.profile_sizes
configuration.logo_sizes
```

## Detail

Every example documented below uses the movie Fight Club (id 550), the TV show Breaking Bad (id 1396), and every person uses Brad Pitt (id 287). These are only used as examples to show what a real world request looks like.

### Movie

```ruby
movie = Tmdb::Movie.detail(550)
movie.adult => false
movie.backdrop_path => "/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg"
movie.belongs_to_collection => nil
movie.budget => 63000000
movie.genres => [{"id"=>28, "name"=>"Action"}, {"id"=>18, "name"=>"Drama"}, {"id"=>53, "name"=>"Thriller"}]
movie.homepage => ""
movie.id => 550
movie.imdb_id => "tt0137523"
movie.original_title => "Fight Club"
movie.overview => "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion."
movie.popularity => 7.4
movie.poster_path => "/2lECpi35Hnbpa4y46JX0aY3AWTy.jpg"
movie.production_companies => [{"name"=>"20th Century Fox", "id"=>25}, {"name"=>"Fox 2000 Pictures", "id"=> 711}, {"name"=>"Regency Enterprises", "id"=>508}]
movie.production_countries => [{"iso_3166_1"=>"DE", "name"=>"Germany"}, {"iso_3166_1"=>"US", "name"=>"United States of America"}]
movie.release_date => "1999-10-14"
movie.revenue => 100853753
movie.runtime => 139
movie.spoken_languages => [{"iso_639_1"=>"en", "name"=>"English"}]
movie.status => "Released"
movie.tagline => "How much can you know about yourself if you've never been in a fight?"
movie.title => "Fight Club"
movie.vote_average => 8.8
movie.vote_count => 234
```
Get the latest movie id.
```ruby
Tmdb::Movie.latest
```
Get the list of upcoming movies. This list refreshes every day. The maximum number of items this list will include is 100.
```ruby
Tmdb::Movie.upcoming
```
Get the list of movies playing in theatres. This list refreshes every day. The maximum number of items this list will include is 100.
```ruby
Tmdb::Movie.now_playing
```
Get the list of popular movies on The Movie Database. This list refreshes every day.
```ruby
Tmdb::Movie.popular
```
Get the list of top rated movies. By default, this list will only include movies that have 10 or more votes. This list refreshes every day.
```ruby
Tmdb::Movie.top_rated
```
#### Movie - Alternative Titles
Get the alternative titles for a specific movie id.
```ruby
Tmdb::Movie.alternative_titles(22855)
```
#### Movie - Images
Get the images (posters and backdrops) for a specific movie id.
```ruby
@movie = Tmdb::Movie.images(22855)
```
Grab Backdrops
```ruby
@movie['backdrops']
```
Grab Posters
```ruby
@movie['posters']
```

#### Movie - Casts
Get the cast information for a specific movie id.
```ruby
Tmdb::Movie.casts(22855)
```
#### Movie - Keywords
Get the plot keywords for a specific movie id.
```ruby
Tmdb::Movie.keywords(22855)
```
#### Movie - Releases
Get the release date by country for a specific movie id.
```ruby
Tmdb::Movie.releases(22855)
```
#### Movie - Trailers
Get the trailers for a specific movie id.
```ruby
Tmdb::Movie.trailers(22855)
```
#### Movie - Translations
Get the translations for a specific movie id.
```ruby
Tmdb::Movie.translations(22855)
```
#### Movie - Similar Movies
Get the similar movies for a specific movie id.
```ruby
Tmdb::Movie.similar_movies(22855)
```
#### Movie - Lists
Get the lists that the movie belongs to.
```ruby
Tmdb::Movie.lists(22855)
```
#### Movie - Changes
Get the changes for a specific movie id.
```ruby
Tmdb::Movie.changes(22855)
```
#### Movie - Credits
Get the credits for a specific movie id.
```ruby
Tmdb::Movie.credits(22855)
```

### TV

```ruby
show = Tmdb::TV.detail(1396)
```
Get the list of popular TV shows. This list refreshes every day.
```ruby
Tmdb::TV.popular
```
Get the list of top rated TV shows. By default, this list will only include TV shows that have 2 or more votes. This list refreshes every day.
```ruby
Tmdb::TV.top_rated
```
#### TV - Images
Get the images (posters and backdrops) for a TV series.
```ruby
@show = Tmdb::TV.images(1396)
```
Grab Backdrops
```ruby
@show['backdrops']
```
Grab Posters
```ruby
@show['posters']
```
#### TV - Cast
Get the cast information about a TV series.
```ruby
Tmdb::TV.cast(1396)
```
#### TV - Crew
Get the crew information about a TV series.
```ruby
Tmdb::TV.crew(1396)
```
#### TV - External IDs
Get the external ids that we have stored for a TV series.
```ruby
Tmdb::TV.external_ids(1396)
```

### Season

```ruby
show = Tmdb::Season.detail(1396, 1)
```
#### Season - Images
Get the images (posters) that we have stored for a TV season by season number.
```ruby
@season = Tmdb::Season.images(1396, 1)
```
Grab Posters
```ruby
@season['posters']
```
#### Season - Cast
Get the cast credits for a TV season by season number.
```ruby
Tmdb::Season.cast(1396, 1)
```
#### Season - Crew
Get the crew credits for a TV season by season number.
```ruby
Tmdb::Season.crew(1396, 1)
```
#### Season - External IDs
Get the external ids that we have stored for a TV season by season number.
```ruby
Tmdb::Season.external_ids(1396, 1)
```

### Episode

```ruby
episode = Tmdb::Episode.detail(1396, 1, 1)
```
#### Episode - Images
Get the images (episode stills) for a TV episode by combination of a season and episode number.
```ruby
@episode = Tmdb::Episode.images(1396, 1, 1)
```
Grab Stills
```ruby
@episode['stills']
```
#### Episode - Cast
Get the TV episode cast credits by combination of season and episode number.
```ruby
Tmdb::Episode.cast(1396, 1, 1)
```
#### Episode - Crew
Get the TV episode crew credits by combination of season and episode number.
```ruby
Tmdb::Episode.crew(1396, 1, 1)
```
#### Episode - External IDs
Get the external ids for a TV episode by comabination of a season and episode number.
```ruby
Tmdb::Episode.external_ids(1396, 1, 1)
```

### Company
```ruby
company = Tmdb::Company.detail(1)
company.id => 1
company.description => nil
company.homepage => "http://www.lucasfilm.com"
company.logo_path => "/8rUnVMVZjlmQsJ45UGotDOUznxj.png"
company.name => "Lucasfilm"
company.parent_company => nil
```

Get the list of movies associated with a particular company.
```ruby
Tmdb::Company.movies(1)
```

### Collection
```ruby
collection = Tmdb::Collection.detail(51845)
collection.id => 51845
collection.backdrop_path => "..."
collection.parts => "..."
collection.poster_path => "..."
collection.name => "DC Universe Animated Original Movies"
```

Get all of the images for a particular collection by collection id.
```ruby
Tmdb::Collection.images(51845)
```

### Person

```ruby
person = Tmdb::Person.detail(287)
person.id => 287
person.name => "Brad Pitt"
person.place_of_birth => "Shawnee, Oklahoma, United States"
person.also_known_as => []
person.adult => false
person.biography => "From Wikipedia, the free"..
person.birthday => "1963-12-18"
person.deathday => ""
person.homepage => "http://simplybrad.com/"
person.profile_path => "w8zJQuN7tzlm6FY9mfGKihxp3Cb.jpg"
```

Get the list of popular people on The Movie Database. This list refreshes every day.
```ruby
Tmdb::Person.popular
```

Get the latest person id.
```ruby
Tmdb::Person.latest
```

Get the credits for a specific person id.
```ruby
Tmdb::Person.credits(287)
```

Get the images for a specific person id.
```ruby
Tmdb::Person.images(287)
```

Get the changes for a specific person id.
```ruby
Tmdb::Person.changes(287)
```

### Genre

```ruby
genre = Tmdb::Genre.detail(18)
genre.id => 18
genre.name => "Drama"
genre.page => 1
genre.total_pages => 45
genre.total_results => 883
genre.results => [...]
genre.get_page(page_number) => Returns next set of movies.
```

Get a list of all genres.
```ruby
Tmdb::Genre.list
```

### Job

Get a list of all jobs.
```ruby
Tmdb::Job.list
```

## License

themoviedb - A ruby wrapper for the movie database API

Copyright (C) 2016  Ahmet Abdi

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
