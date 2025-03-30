require 'minitest/autorun'
require 'minitest-spec-context'
require 'minitest/spec'
require 'ostruct'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../fixtures/vcr_cassettes', __FILE__)
  config.hook_into :webmock
end

def api_key
  if ENV['COINMARKETCAP_API_KEY']
    ENV['COINMARKETCAP_API_KEY']
  else
    'api_key0'
  end
end
