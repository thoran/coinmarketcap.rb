# CoinMarketCap/V1/Client.rb
# CoinMarketCap::V1::Client

# Notes:
# 1. From https://coinmarketcap.com/api/documentation/v1/#tag/cryptocurrency
# /v1/cryptocurrency/airdrop - Airdrop
# /v1/cryptocurrency/airdrops - Airdrops
# /v1/cryptocurrency/categories - Categories
# /v1/cryptocurrency/category - Category
# /v1/cryptocurrency/listings/historical - Historical listings
# /v1/cryptocurrency/listings/latest - Latest listings
# /v1/cryptocurrency/map - CoinMarketCap ID map
# /v1/cryptocurrency/trending/gainers-losers - Trending Gainers & Losers
# /v1/cryptocurrency/trending/latest - Trending Latest
# /v1/cryptocurrency/trending/most-visited - Trending Most Visited

gem 'http.rb'
require 'http.rb'
require 'json'
require_relative '../Common'

module CoinMarketCap
  module V1
    class Client
      include Common

      class << self
        def path_prefix
          '/v1/cryptocurrency'
        end
      end # class << self

      def listings_latest
        response = get(path: '/listings/latest')
        handle_response(response)
      end
    end
  end
end
