# coinmarketcap.rb

## Description

Access the coinmarketcap.com API with Ruby.

## Installation

Add this line to your application's Gemfile:
```ruby
  gem 'coinmarketcap.rb'
```
And then execute:
```bash
  $ bundle
```
Or install it yourself as:
```bash
  $ gem install coinmarketcap.rb
```

## Notes

This gem attempts to make sense of a CoinMarketCap's somewhat confused APIs and so far only partially covers off V1 and V2 APIs. It makes sense of the V1 and V2 APIs by creating a mezzanine, API version agnostic client which will use V1 or V2 endpoints/sub-clients selectively depending on which retrieves the requested information whilst giving a cleaner and more consistent overall interface. It is likely that further abstraction/simplification of the APIs is possible, further improving the usability.

## Usage

### Setup
```ruby
api_key = 'api_key0'
coinmarketcap_client ||= CoinMarketCap::Client.new(api_key: api_key)
```

### Airdrops
```ruby
coinmarketcap_client.airdrops
coinmarketcap_client.airdrops(id: 123)
```

### Categories
```ruby
coinmarketcap_client.categories
coinmarketcap_client.categories(id: 123)
```

### Gainers and Losers
```ruby
coinmarketcap_client.gainers_and_losers
```

### Historical Price Data (OHLCV)
```ruby
coinmarketcap_client.historical_price_data(id: 123)
```

### Historical Quotes
```ruby
coinmarketcap_client.historical_quotes
coinmarketcap_client.historical_quotes(id: 123)
```

### Info for a Specific Coin
```ruby
coinmarketcap_client.info(id: 123)
```

### Latest Coin Pairs Listed
```ruby
coinmarketcap_client.latest_listings
```

### Latest Price Data (OHLCV)
```ruby
coinmarketcap_client.latest_price_data
```

### Latest Performance Stats
```ruby
coinmarketcap_client.latest_price_performance_stats
```

### Latest Quotes
```ruby
coinmarketcap_client.latest_quotes
coinmarketcap_client.latest_quotes(id: 123)
```

### Most Visited Coins
```ruby
coinmarketcap_client.most_visited
```

### Trending Coins
```ruby
coinmarketcap_client.trending
```

## Contributing

1. Fork it ( https://github.com/thoran/eodhd.rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
