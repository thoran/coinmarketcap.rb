require_relative './lib/CoinMarketCap/VERSION'

Gem::Specification.new do |spec|
  spec.name = 'coinmarketcap.rb'

  spec.version = CoinMarketCap::VERSION
  spec.date = '2025-03-30'

  spec.summary = "Access the coinmarketcap.com API with Ruby."
  spec.description = "Access the coinmarketcap.com API with Ruby."

  spec.author = 'thoran'
  spec.email = 'code@thoran.com'
  spec.homepage = 'http://github.com/thoran/coinmarketcap.rb'
  spec.license = 'Ruby'

  spec.required_ruby_version = '>= 2.7'

  spec.add_dependency('http.rb')
  spec.files = [
    'coinmarketcap.rb.gemspec',
    'Gemfile',
    Dir['lib/**/*.rb'],
    'README.md',
    Dir['test/**/*.rb']
  ].flatten
  spec.require_paths = ['lib']
end
