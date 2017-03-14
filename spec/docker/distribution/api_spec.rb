require 'spec_helper'
require 'logger'

describe Docker::Distribution::Api do
  before do
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    described_class.logger = logger
  end

  before :all do
    `docker pull busybox`
    `docker tag busybox localhost:5000/test`
    `docker push localhost:5000/test`
  end

  it 'has a version number' do
    expect(Docker::Distribution::Api::VERSION).not_to be nil
  end

  describe '#version' do
    it 'works' do
      expect(described_class.version).to eq('registry/2.0')
    end
  end

  describe '#tags' do
    it 'works' do
      expect(described_class.tags('test')).to eq(['latest'])
    end
  end
end
