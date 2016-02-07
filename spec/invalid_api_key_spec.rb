require 'rspec'
require 'spec_helper'

describe 'invalid API key' do
  after(:all) { Tmdb::Api.key($VALID_API_KEY) }
  it 'raises error for nil key' do
    Tmdb::Api.key(nil)
    VCR.use_cassette 'api_key/nil_key' do
      expect { Tmdb::Movie.search('batman') }.to raise_error(Tmdb::InvalidApiKeyError)
    end
  end
  it 'raises error for empty string key' do
    Tmdb::Api.key('')
    VCR.use_cassette 'api_key/empty_string' do
      expect { Tmdb::Movie.search('batman') }.to raise_error(Tmdb::InvalidApiKeyError)
    end
  end
  it 'raises error invalid nonempty key' do
    Tmdb::Api.key('bad-key')
    VCR.use_cassette 'api_key/invalid_key' do
      expect { Tmdb::Movie.search('batman') }.to raise_error(Tmdb::InvalidApiKeyError)
    end
  end
end
