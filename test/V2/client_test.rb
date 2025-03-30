require_relative '../helper'
require_relative '../../lib/CoinMarketCap/V2/Client'

describe CoinMarketCap::V2::Client do
  let(:client) {CoinMarketCap::V2::Client.new(api_key: api_key)}

  describe "#info" do
    it "retrieves metadata for a specific cryptocurrency" do
      VCR.use_cassette('v2/cryptocurrency/info') do
        response = client.info(id: 1)
        _(response).must_include('data')
        _(response.dig('data', '1', 'symbol')).must_equal 'BTC'
      end
    end
  end

  describe "#market_pairs_latest" do
    it "retrieves the latest market pairs" do
      VCR.use_cassette('v2/cryptocurrency/market-pairs/latest') do
        assert_raises CoinMarketCap::Error do
          response = client.market_pairs_latest
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#ohlcv_historical" do
    it "retrieves historical OHLCV data" do
      VCR.use_cassette('v2/cryptocurrency/ohlcv/historical') do
        assert_raises CoinMarketCap::Error do
          response = client.ohlcv_historical(id: 1)
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#ohlcv_latest" do
    it "returns the latest OHLCV data" do
      VCR.use_cassette('v2/cryptocurrency/ohlcv/latest') do
        assert_raises CoinMarketCap::Error do
          response = client.ohlcv_latest
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#price_performance_stats_latest" do
    it "retrieves the latest price performance statistics" do
      VCR.use_cassette('v2/cryptocurrency/price-performance-stats/latest') do
        assert_raises CoinMarketCap::Error do
          response = client.price_performance_stats_latest
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#quotes_historical" do
    it "returns historical quotes" do
      VCR.use_cassette('v2/cryptocurrency/quotes/historical') do
        assert_raises CoinMarketCap::Error do
          response = client.quotes_historical(id: 1)
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#quotes_latest" do
    it "retrieves the latest quotes for a specific cryptocurrency" do
      VCR.use_cassette('v2/cryptocurrency/quotes/latest') do
        response = client.quotes_latest(id: 1)
        _(response).must_include('data')
        _(response['data']).must_be_kind_of(Hash)

      end
    end

    it "retrieves quotes for multiple IDs" do
      VCR.use_cassette('v2/cryptocurrency/quotes/latest_with_multiple_ids') do
        response = client.quotes_latest(id: [1, 2])
        _(response).must_include("data")
        _(response["data"]).must_be_kind_of(Hash)
      end
    end
  end

  describe "#handle_response" do
    it "handles a successful response" do
      raw_response = OpenStruct.new(success?: true, body: '{"data": {}}')
      response = client.send(:handle_response, raw_response)
      _(response).must_include('data')
      _(response).must_be_kind_of(Hash)
    end

    it "raises an error for a failed response" do
      response = OpenStruct.new(success?: false, code: 404, message: 'Not Found')
      assert_raises RuntimeError do
        client.send(:handle_response, response)
      end
    end
  end
end
