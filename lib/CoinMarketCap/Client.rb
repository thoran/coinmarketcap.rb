require_relative './V1/Client'
require_relative './V2/Client'

module CoinMarketCap
  class Client
    def airdrops(id: nil)
      if id
        v1_client.airdrop(id: id)
      else
        v1_client.airdrops
      end
    end

    def categories(id: nil)
      if id
        v1_client.category(id: id)
      else
        v1_client.categories
      end
    end

    def map
      v1_client.map
    end

    def info(id:)
      v2_client.info(id: id)
    end

    def market_pairs_latest
      v2_client.market_pairs_latest
    end

    def ohlcv_historical(id:)
      v2_client.ohlcv_historical(id: id)
    end

    def ohlcv_latest
      v2_client.ohlcv_latest
    end

    def price_performance_stats_latest
      v2_client.price_performance_stats_latest
    end

    def quotes_latest(id: nil)
      if id
        v2_client.quotes_latest(id: id)
      else
        v1_client.listings_latest
      end
    end
    alias_method :quotes, :quotes_latest

    def quotes_historical(id: nil)
      if id
        v2_client.quotes_historical(id: id)
      else
        v1_client.listings_historical
      end
    end

    def trending_gainers_losers
      v1_client.trending_gainers_losers
    end

    def trending_latest
      v1_client.trending_latest
    end

    def trending_most_visited
      v1_client.trending_most_visited
    end

    private

    def initialize(api_key:)
      @api_key = api_key
    end

    def v1_client
      @v1_client ||= CoinMarketCap::V1::Client.new(api_key: @api_key)
    end

    def v2_client
      @v2_client ||= CoinMarketCap::V2::Client.new(api_key: @api_key)
    end
  end
end
