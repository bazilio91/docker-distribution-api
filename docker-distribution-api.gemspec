# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docker/distribution/api/version'

Gem::Specification.new do |spec|
  spec.name          = 'docker-distribution-api'
  spec.version       = Docker::Distribution::Api::VERSION
  spec.authors       = ['Vasily Ostanin']
  spec.email         = ['bazilio91@gmail.com']

  spec.summary       = %q{API client for docker distribution.}
  spec.description   = %q{docker-api like client for docker self-hosted registry (distribution).}
  spec.homepage      = 'https://github.com/bazilio91/docker-distribution-api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'excon', '>= 0.38.0'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
