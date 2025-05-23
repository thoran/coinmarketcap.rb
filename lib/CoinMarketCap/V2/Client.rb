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
require_relative '../Common'

module CoinMarketCap
  module V2
    class Client
      include Common

      class << self
        def path_prefix
          '/v2/cryptocurrency'
        end
      end # class << self

      def info(id:)
        response = get(path: '/info', args: {id: id})
        handle_response(response)
      end

      def market_pairs_latest(**args)
        response = get(path: '/market-pairs/latest', args: args)
        handle_response(response)
      end

      def ohlcv_historical(id:)
        response = get(path: '/ohlcv/historical', args: {id: id})
        handle_response(response)
      end

      def ohlcv_latest
        response = get(path: '/ohlcv/latest')
        handle_response(response)
      end

      def price_performance_stats_latest
        response = get(path: '/price-performance-stats/latest')
        handle_response(response)
      end

      def quotes_historical(id:)
        response = get(path: '/quotes/historical', args: {id: id})
        handle_response(response)
      end

      def quotes_latest(id:)
        id = [id].compact.join(',')
        response = get(path: '/quotes/latest', args: {id: id})
        handle_response(response)
      end
    end
  end
end
