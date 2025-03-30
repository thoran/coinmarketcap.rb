require_relative './helper'
require_relative '../lib/CoinMarketCap/Client'

describe CoinMarketCap::Client do
  let(:client){CoinMarketCap::Client.new(api_key: api_key)}

  describe "#airdrops" do
    context "when an id IS provided" do
      it "calls the V1 client" do
        mocked_client = Minitest::Mock.new
        mocked_client.expect(:airdrop, {'data' => []}) do |kwargs|
          kwargs[:id] == 1
        end
        client.stub :v1_client, mocked_client do
          client.airdrops(id: 1)
        end
        mocked_client.verify
      end
    end

    context "when an id is NOT provided" do
      it "calls the V1 client" do
        mocked_client = Minitest::Mock.new
        mocked_client.expect :airdrops, true, []
        client.stub :v1_client, mocked_client do
          client.airdrops
        end
        mocked_client.verify
      end
    end
  end

  describe "#categories" do
    context "when an id IS provided" do
      it "calls the V1 client" do
        mocked_client = Minitest::Mock.new
        mocked_client.expect(:category, {'data' => []}) do |kwargs|
          kwargs[:id] == 1
        end
        client.stub :v1_client, mocked_client do
          client.categories(id: 1)
        end
        mocked_client.verify
      end
    end

    context "when an id is NOT provided" do
      it "calls the V1 client" do
        mocked_client = Minitest::Mock.new
        mocked_client.expect :categories, true, []
        client.stub :v1_client, mocked_client do
          client.categories
        end
        mocked_client.verify
      end
    end
  end

  describe "#info" do
    it "calls the V2 client" do
      mocked_client = Minitest::Mock.new
      mocked_client.expect(:info, {'data' => []}) do |kwargs|
        kwargs[:id] == 1
      end
      client.stub :v2_client, mocked_client do
        client.info(id: 1)
      end
      mocked_client.verify
    end
  end

  describe "#map" do
    it "calls the V1 client" do
      mocked_client = Minitest::Mock.new
      mocked_client.expect(:map, {'data' => []})
      client.stub :v1_client, mocked_client do
        client.map
      end
      mocked_client.verify
    end
  end

  describe "#market_pairs_latest" do
    it "calls the V2 client" do
      mocked_client = Minitest::Mock.new
      mocked_client.expect(:market_pairs_latest, true, [])
      client.stub :v2_client, mocked_client do
        client.market_pairs_latest
      end
      mocked_client.verify
    end
  end

  describe "#ohlcv_historical" do
    it "calls the V2 client" do
      mocked_client = Minitest::Mock.new
      mocked_client.expect(:ohlcv_historical, {'data' => []}) do |kwargs|
        kwargs[:id] == 1
      end
      client.stub :v2_client, mocked_client do
        client.ohlcv_historical(id: 1)
      end
      mocked_client.verify
    end
  end

  describe "#ohlcv_latest" do
    it "calls the V2 client" do
      mocked_client = Minitest::Mock.new
      mocked_client.expect(:ohlcv_latest, true, [])
      client.stub :v2_client, mocked_client do
        client.ohlcv_latest
      end
      mocked_client.verify
    end
  end

  describe "#quotes_latest" do
    context "when an ID IS provided" do
      it "calls the V2 client" do
        mocked_client = Minitest::Mock.new
        mocked_client.expect(:quotes_latest, {'data' => []}) do |kwargs|
          kwargs[:id] == 1
        end
        client.stub :v2_client, mocked_client do
          client.quotes_latest(id: 1)
        end
        mocked_client.verify
      end
    end

    context "when an ID is NOT provided" do
      it "calls the V1 client" do
        mocked_client = Minitest::Mock.new
        mocked_client.expect(:listings_latest, true, [])
        client.stub :v1_client, mocked_client do
          client.quotes_latest
        end
        mocked_client.verify
      end
    end
  end

  describe "#quotes_historical" do
    context "when an ID IS provided" do
      it "calls the V2 client" do
        mocked_client = Minitest::Mock.new
        mocked_client.expect(:quotes_historical, {'data' => []}) do |kwargs|
          kwargs[:id] == 1
        end
        client.stub :v2_client, mocked_client do
          client.quotes_historical(id: 1)
        end
        mocked_client.verify
      end
    end

    context "when no ID is provided" do
      it "calls the V1 client" do
        mocked_client = Minitest::Mock.new
        mocked_client.expect :listings_historical, {"data" => {}}, []
        client.stub :v1_client, mocked_client do
          client.quotes_historical
        end
        mocked_client.verify
      end
    end
  end

  describe "#trending_gainers_losers" do
    it "calls the V1 client trending_gainers_losers method" do
      mocked_client = Minitest::Mock.new
      mocked_client.expect :trending_gainers_losers, true, []
      client.stub :v1_client, mocked_client do
        client.trending_gainers_losers
      end
      mocked_client.verify
    end
  end

  describe "#trending_latest" do
    it "calls the V1 client trending_latest method" do
      mocked_client = Minitest::Mock.new
      mocked_client.expect :trending_latest, true, []
      client.stub :v1_client, mocked_client do
        client.trending_latest
      end
      mocked_client.verify
    end
  end

  describe "#trending_most_visited" do
    it "calls the V1 client trending_most_visited method" do
      mocked_client = Minitest::Mock.new
      mocked_client.expect :trending_most_visited, true, []
      client.stub :v1_client, mocked_client do
        client.trending_most_visited
      end
      mocked_client.verify
    end
  end
end
