# CoinMarketCapClient.rb
# CoinMarketCapClient

# 20250303
# 0.0.0

require 'httparty'

class CoinMarketCapClient
  BASE_URL = 'https://pro-api.coinmarketcap.com/v1'

  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_cryptocurrency_list
    response = HTTParty.get("#{BASE_URL}/cryptocurrency/listings/latest", headers: headers)
    handle_response(response)
  end

  def fetch_cryptocurrency_by_id(id)
    response = HTTParty.get("#{BASE_URL}/cryptocurrency/info?id=#{id}", headers: headers)
    handle_response(response)
  end

  private

  def headers
    { 'X-CMC_PRO_API_KEY' => @api_key, 'Accept' => 'application/json' }
  end

  def handle_response(response)
    if response.success?
      response.parsed_response
    else
      raise "Error: #{response.code} - #{response.message}"
    end
  end
end
