# CoinMarketCap/Common.rb
# CoinMarketCap::Common

module CoinMarketCap
  class Error < RuntimeError
    attr_reader :code, :message, :body

    private

    def initialize(code:, message:, body:)
      @code = code
      @message = message
      @body = body
    end
  end

  module Common
    API_HOST = 'pro-api.coinmarketcap.com'

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
        raise CoinMarketCap::Error.new(
          code: response.code,
          message: response.message,
          body: response.body,
        )
      end
    end
  end
end
