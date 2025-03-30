require 'minitest/autorun'
require 'minitest/spec'
require 'ostruct'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../fixtures/vcr_cassettes', __FILE__)
  config.hook_into :webmock
end
