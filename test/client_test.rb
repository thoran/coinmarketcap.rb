require 'minitest/autorun'
require 'minitest/spec'
require 'ostruct'

require_relative '../lib/CoinMarketCap/Client'

describe CoinMarketCap::Client do
  let(:client) {CoinMarketCap::Client.new(api_key: ARGV[0])}

  describe "#cryptocurrency_list" do
    it "returns an array of cryptocurrencies" do
      response = client.cryptocurrency_list
       _(response['data']).must_be_kind_of(Array)
    end
  end

  describe "#cryptocurrency_by_id" do
    it "returns data for a specific cryptocurrency by ID" do
      response = client.cryptocurrency_by_id(1)
      _(response).must_include('data')
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
