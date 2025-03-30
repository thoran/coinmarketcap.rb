require 'minitest/autorun'
require 'minitest/spec'
require 'ostruct'

require_relative '../lib/CoinMarketCap/Client'

describe CoinMarketCap::Client do
  let(:client) {CoinMarketCap::Client.new(api_key: ARGV[0])}

  describe "#quotes" do
    it "returns quotes for all cryptos" do
      response = client.quotes
      _(response).must_include('data')
      _(response['data']).must_be_kind_of(Array)
    end

    it "returns data for a specific crypto by ID" do
      response = client.quotes(id: 1)
      _(response).must_include('data')
      _(response['data']).must_be_kind_of(Hash)
    end
  end
end
