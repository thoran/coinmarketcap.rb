require_relative '../helper'
require_relative '../../lib/CoinMarketCap/V1/Client'

describe CoinMarketCap::V1::Client do
  let(:client) {CoinMarketCap::V1::Client.new(api_key: 'api_key0')}

  describe "#listings_latest" do
    it "returns an array of latest prices" do
      VCR.use_cassette('v1/cryptocurrency/listings/latest') do
        response = client.listings_latest
         _(response['data']).must_be_kind_of(Array)
         _(response['data'][0]).must_be_kind_of(Hash)
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
