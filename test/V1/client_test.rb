require_relative '../helper'
require_relative '../../lib/CoinMarketCap/V1/Client'

describe CoinMarketCap::V1::Client do
  let(:client) {CoinMarketCap::V1::Client.new(api_key: api_key)}

  describe "#airdrop" do
    it "returns AN airdrop" do
      VCR.use_cassette('v1/cryptocurrency/airdrop') do
        assert_raises CoinMarketCap::Error do
          response = client.airdrop(id: 1)
          # Too poor to subscribe...
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#airdrops" do
    it "returns ALL airdrops" do
      VCR.use_cassette('v1/cryptocurrency/airdrops') do
        assert_raises CoinMarketCap::Error do
          response = client.airdrops
          # Still too poor to subscribe...
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#categories" do
    it "returns ALL categories" do
      VCR.use_cassette('v1/cryptocurrency/categories') do
        assert_raises CoinMarketCap::Error do
          response = client.categories
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#category" do
    it "returns a specific category" do
      VCR.use_cassette('v1/cryptocurrency/category') do
        assert_raises CoinMarketCap::Error do
          response = client.category(id: 1)
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#listings_historical" do
    it "returns historical listings for all cryptos" do
      VCR.use_cassette('v1/cryptocurrency/listings/historical') do
        assert_raises CoinMarketCap::Error do
          response = client.listings_historical
          _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#listings_latest" do
    it "returns an array of latest prices" do
      VCR.use_cassette('v1/cryptocurrency/listings/latest') do
        response = client.listings_latest
        _(response).must_include('data')
        _(response['data']).must_be_kind_of(Array)
        _(response['data'][0]).must_be_kind_of(Hash)
      end
    end
  end

  describe "#map" do
    it "returns a map of crypto IDs to symbols" do
      VCR.use_cassette('v1/cryptocurrency/map') do
        response = client.map
        _(response).must_include('data')
        _(response['data'].first['symbol']).must_equal 'BTC'
      end
    end
  end

  describe "#trending_gainers_losers" do
    it "returns trending gainers and losers" do
      VCR.use_cassette('v1/cryptocurrency/trending/gainers-losers') do
        assert_raises CoinMarketCap::Error do
          response = client.trending_gainers_losers
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#trending_latest" do
    it "returns trending latest" do
      VCR.use_cassette('v1/cryptocurrency/trending/latest') do
        assert_raises CoinMarketCap::Error do
          response = client.trending_latest
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
      end
    end
  end

  describe "#trending_most_visited" do
    it "returns trending most visited" do
      VCR.use_cassette('v1/cryptocurrency/trending/most-visited') do
        assert_raises CoinMarketCap::Error do
          response = client.trending_most_visited
          # _(response).must_include('data')
          _(JSON.parse(response.body).dig('status', 'error_message')).must_equal "Your API Key subscription plan doesn't support this endpoint."
        end
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
      raw_response = OpenStruct.new(success?: false, code: 404, message: 'Not Found')
      assert_raises RuntimeError do
        client.send(:handle_response, raw_response)
      end
    end
  end
end
