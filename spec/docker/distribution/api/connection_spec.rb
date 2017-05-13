require 'spec_helper'
require 'logger'

describe Docker::Distribution::Connection do
  before do
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    Docker::Distribution::Api.logger = logger
  end

  describe '#initialize' do
    it 'works with any scheme' do
      url = 'https://host:999'
      expect(URI.parse(described_class.new(url, {}).url).scheme).to eq 'https'

      url = 'http://host:999'
      expect(URI.parse(described_class.new(url, {}).url).scheme).to eq 'http'

      url = 'host:999'
      expect{URI.parse(described_class.new(url, {}).url).scheme}.to_not raise_error
      expect(URI.parse(described_class.new(url, {}).url).scheme).to eq 'http'
    end
  end
end
