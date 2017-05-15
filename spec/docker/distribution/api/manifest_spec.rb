require 'spec_helper'
require 'logger'

describe Docker::Distribution::Api::Manifest do
  before do
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    Docker::Distribution::Api.logger = logger
  end

  before :all do
    `docker pull busybox`
    `docker tag busybox localhost:5000/test`
    `docker push localhost:5000/test`
  end

  describe '#get_by_tag' do
    it 'gets manifest from registry' do
      expect(described_class.get_by_tag('test', 'latest')).to be_a Docker::Distribution::Api::Manifest
    end

    it 'loads digest' do
      expect(described_class.get_by_tag('test', 'latest').info['digest']).to start_with 'sha256:'
    end
  end

  describe '#delete' do
    subject { described_class.get_by_tag('test', 'latest') }

    it 'works' do
      expect(subject.delete).to eq(nil)
    end
  end
end
