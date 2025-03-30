require_relative './helper'
require_relative '../lib/CoinMarketCap/Client'

describe CoinMarketCap::Client do
  let(:client) {CoinMarketCap::Client.new(api_key: 'api_key0')}

  describe "#quotes" do
    it "returns quotes for all cryptos" do
      VCR.use_cassette('quotes_with_no_id') do
        response = client.quotes
        _(response).must_include('data')
        _(response['data']).must_be_kind_of(Array)
      end
    end

    it "returns data for a specific crypto by ID" do
      VCR.use_cassette('quotes_with_id') do
        response = client.quotes(id: 1)
        _(response).must_include('data')
        _(response['data']).must_be_kind_of(Hash)
      end
    end
  end
end
