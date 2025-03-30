# CoinMarketCap/Client.rb
# CoinMarketCap::Client

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

    def gainers_and_losers
      v1_client.trending_gainers_losers
    end

    def historical_price_data(id:)
      v2_client.ohlcv_historical(id: id)
    end

    # I don't see the point of these endpoints at all. (Ha ha!) Either you want current prices or you want historical OHLCV. I don't see why having historical quotes is of any value.
    def historical_quotes(id: nil)
      if id
        v2_client.quotes_historical(id: id)
      else
        v1_client.listings_historical
      end
    end

    def info(id:)
      v2_client.info(id: id)
    end

    def map
      v1_client.map
    end

    def latest_listings
      v2_client.market_pairs_latest
    end

    def latest_price_data
      v2_client.ohlcv_latest
    end

    def most_visited
      v1_client.trending_most_visited
    end

    def latest_price_performance_stats
      v2_client.price_performance_stats_latest
    end

    def latest_quotes(id: nil)
      if id
        v2_client.quotes_latest(id: id)
      else
        v1_client.listings_latest
      end
    end

    def trending
      v1_client.trending_latest
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
