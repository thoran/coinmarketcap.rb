require_relative './V1/Client'
require_relative './V2/Client'

module CoinMarketCap
  class Client

    def v1_client
      @v1_client ||= CoinMarketCap::V1::Client.new(api_key: @api_key)
    end

    def v2_client
      @v2_client ||= CoinMarketCap::V2::Client.new(api_key: @api_key)
    end

    def quotes(id: nil)
      if id
        v2_client.quotes_latest(id: id)
      else
        v1_client.listings_latest
      end
    end

    private

    def initialize(api_key:)
      @api_key = api_key
    end
  end
end
