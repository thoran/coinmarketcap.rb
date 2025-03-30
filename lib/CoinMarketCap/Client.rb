# CoinMarketCap/Client.rb
# CoinMarketCap::Client

# 20250303
# 0.1.0

gem 'http.rb'
require 'http.rb'
require 'json'

module CoinMarketCap
  module V1
    class Client
      API_HOST = 'pro-api.coinmarketcap.com'

      class << self
        def path_prefix
          '/v1'
        end
      end # class << self

      def cryptocurrency_list
        response = get(path: '/cryptocurrency/listings/latest')
        handle_response(response)
      end

      def cryptocurrency_by_id(id)
        response = get(
          path: '/cryptocurrency/info',
          args: {id: id}
        )
        handle_response(response)
      end

      private

      def initialize(api_key:)
        @api_key = api_key
      end

      def request_string(path)
        "https://#{API_HOST}#{self.class.path_prefix}#{path}"
      end

      def headers
        {
          'Accept' => 'application/json',
          'X-CMC_PRO_API_KEY' => @api_key,
        }
      end

      def do_request(verb:, path:, args: {})
        HTTP.send(verb.to_s.downcase, request_string(path), args, headers)
      end

      def get(path:, args: {})
        do_request(verb: 'GET', path: path, args: args)
      end

      def post(path:, args: {})
        do_request(verb: 'POST', path: path, args: args)
      end

      def handle_response(response)
        if response.success?
          JSON.parse(response.body)
        else
          raise "Error: #{response.code} - #{response.message}"
        end
      end
    end
  end

  class Client < CoinMarketCap::V1::Client
end
