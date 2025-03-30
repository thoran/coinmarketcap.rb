require_relative '../helper'
require_relative '../../lib/CoinMarketCap/V2/Client'

describe CoinMarketCap::V2::Client do
  let(:client) {CoinMarketCap::V2::Client.new(api_key: 'api_key0')}

  describe "#info" do
    it "returns data for a specific crypto by ID" do
      VCR.use_cassette('v2/cryptocurrency/info') do
        response = client.info(id: 1)
        _(response).must_include('data')
      end
    end
  end

  describe "#quotes_latest" do
    it "returns an array of cryptos" do
      VCR.use_cassette('v2/cryptocurrency/quotes/latest') do
        response = client.quotes_latest(id: 1)
         _(response['data']).must_be_kind_of(Hash)
      end
    end
  end

  describe "#handle_response" do
    it "handles a successful response" do
      response = OpenStruct.new(success?: true, body: '{"data": {}}')
      result = client.send(:handle_response, response)
      _(result).must_be_kind_of(Hash)
    end

    it "raises an error for a failed response" do
      response = OpenStruct.new(success?: false, code: 404, message: 'Not Found')
      assert_raises RuntimeError do
        client.send(:handle_response, response)
      end
    end
  end
end
