module Docker
  module Distribution
    module Api
      class Manifest
        attr_accessor :connection, :info

        require 'docker/distribution/error'
        require 'docker/distribution/api/util'

        def initialize(connection, hash={})
          unless connection.is_a?(Docker::Distribution::Connection)
            raise ArgumentError, "Expected a Docker::Distribution::Connection, got: #{connection}."
          end
          @connection, @info = connection, hash
        end

        def delete
          @connection.delete(
            "/#{@info['repository']}/manifests/#{@info['digest']}",
            nil,
            :expects => [202]
          )
          nil
        end

        def self.get_by_tag(repository, tag, connection = Api.connection)
          response = connection.get(
            "/#{repository}/manifests/#{tag}", nil, :headers => {:Accept => 'application/vnd.docker.distribution.manifest.v2+json'}
          )
          manifest_json = Util.parse_json(response.body)
          hash = manifest_json
          hash['digest'] = response.headers['Docker-Content-Digest']
          hash['repository'] = repository
          hash['tag'] = tag
          new(connection, hash)
        end
      end
    end
  end
end