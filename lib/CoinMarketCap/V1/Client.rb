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

      def airdrop(id:)
        response = get(path: '/airdrop', args: {id: id})
        handle_response(response)
      end

      def airdrops
        response = get(path: '/airdrops')
        handle_response(response)
      end

      def categories
        response = get(path: '/categories')
        handle_response(response)
      end

      def category(id:)
        response = get(path: '/category', args: {id: id})
        handle_response(response)
      end

      def listings_historical
        response = get(path: '/listings/historical')
        handle_response(response)
      end

      def listings_latest
        response = get(path: '/listings/latest')
        handle_response(response)
      end

      def map
        response = get(path: '/map')
        handle_response(response)
      end

      def trending_gainers_losers
        response = get(path: '/trending/gainers-losers')
        handle_response(response)
      end

      def trending_latest
        response = get(path: '/trending/latest')
        handle_response(response)
      end

      def trending_most_visited
        response = get(path: '/trending/most-visited')
        handle_response(response)
      end
    end
  end
end
