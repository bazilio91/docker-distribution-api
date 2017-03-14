# Docker::Distribution::Api

Simple swipley/docker-api like API client for docker-distribution with limited support of endpoints

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'docker-distribution-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install docker-distribution-api

## Usage

API:

```ruby
Docker::Distribution::Api.logger # to set your logger
Docker::Distribution::Api.url= # set registry url
Docker::Distribution::Api.options= # set registry connection options
Docker::Distribution::Api.version # get registry version
Docker::Distribution::Api.tags('test') # get tags for repository 'test'
```

Manifest:

```ruby
Docker::Distribution::Api.url='http://localhost:5000'
Docker::Distribution::Api.options={:user => 'username', :password => 'password'} # basic auth
manifest = Docker::Distribution::Api::Manifest.find_by_tag('repository', 'tag') # get manifest
manifest.delete # delete manifest
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bazilio91/docker-distribution-api.

