require "docker/distribution/api/version"

module Docker
  module Distribution
    module Api
      attr_accessor :creds, :logger

      require 'docker/distribution/api/version'
      require 'docker/distribution/api/connection'
      require 'docker/distribution/api/util'

      def version(connection = self.connection)
        response = connection.get('/')
        response.headers['Docker-Distribution-Api-Version']
      end

      def tags(repository, connection = self.connection)
        response = connection.get("/#{repository}/tags/list")
        Util.parse_json(response.body)['tags']
      end

      def url
        @url ||= 'localhost:5000'
      end

      def url=(new_url)
        @url = new_url
        reset_connection!
      end

      def options
        @options ||= {}
      end

      def options=(new_options)
        @options = @options.merge(new_options || {})
        reset_connection!
      end

      def connection
        @connection ||= Connection.new(url, options)
      end

      def reset_connection!
        @connection = nil
      end

      module_function :url, :url=,
                      :options, :options=,
                      :connection, :reset_connection!,
                      :logger, :logger=,
                      :version, :tags
    end
  end
end
