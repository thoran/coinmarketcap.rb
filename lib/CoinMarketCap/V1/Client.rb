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

module CoinMarketCap
  module V1
    class Client
      API_HOST = 'pro-api.coinmarketcap.com'

      class << self
        def path_prefix
          '/v1/cryptocurrency'
        end
      end # class << self

      def listings_latest
        response = get(path: '/listings/latest')
        handle_response(response)
      end

      private

      def initialize(api_key:)
        @api_key = api_key
      end

      def request_string(path)
        "https://#{API_HOST}#{self.class.path_prefix}#{path}"
      end

      def headers
        {
          'Accept' => 'application/json',
          'X-CMC_PRO_API_KEY' => @api_key,
        }
      end

      def do_request(verb:, path:, args: {})
        HTTP.send(verb.to_s.downcase, request_string(path), args, headers)
      end

      def get(path:, args: {})
        do_request(verb: 'GET', path: path, args: args)
      end

      def post(path:, args: {})
        do_request(verb: 'POST', path: path, args: args)
      end

      def handle_response(response)
        if response.success?
          JSON.parse(response.body)
        else
          raise "Error: #{response.code} - #{response.message}"
        end
      end
    end
  end
end
