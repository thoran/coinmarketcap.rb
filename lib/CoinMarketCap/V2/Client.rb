# CoinMarketCap/V2/Client.rb
# CoinMarketCap::V2::Client

# Notes:
# 1. From https://coinmarketcap.com/api/documentation/v1/#tag/cryptocurrency
# /v2/cryptocurrency/info - Metadata
# /v2/cryptocurrency/market-pairs/latest - Latest market pairs
# /v2/cryptocurrency/ohlcv/historical - Historical OHLCV
# /v2/cryptocurrency/ohlcv/latest - Latest OHLCV
# /v2/cryptocurrency/price-performance-stats/latest - Price performance Stats
# /v2/cryptocurrency/quotes/historical - Historical quotes
# /v2/cryptocurrency/quotes/latest - Latest quotes

gem 'http.rb'
require 'http.rb'
require 'json'

module CoinMarketCap
  module V2
    class Client
      API_HOST = 'pro-api.coinmarketcap.com'

      class << self
        def path_prefix
          '/v2/cryptocurrency'
        end
      end # class << self

      def info(id:)
        response = get(path: '/info', args: {id: id})
        handle_response(response)
      end

      def quotes_latest(id:)
        response = get(path: '/quotes/latest', args: {id: id})
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
