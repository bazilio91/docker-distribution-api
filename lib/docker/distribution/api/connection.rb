module Docker
  module Distribution
    class Connection
      require 'excon'
      require 'docker/distribution/error'

      include Docker::Distribution::Error

      attr_reader :url, :options

      # Create a new Connection. This method takes a url (String) and options
      # (Hash). These are passed to Excon, so any options valid for `Excon.new`
      # can be passed here.
      def initialize(url, opts)
        case
          when !url.is_a?(String)
            raise ArgumentError, "Expected a String, got: '#{url.class}'"
          when !opts.is_a?(Hash)
            raise ArgumentError, "Expected a Hash, got: '#{opts.class}'"
          else
            uri = URI.parse(url)
            if ['https', 'http'].include? uri.scheme
              @url, @options = url, opts
            else
              @url, @options = "http://#{uri}", opts
            end
        end
      end

      # The actual client that sends HTTP methods to the Docker server. This value
      # is not cached, since doing so may cause socket errors after bad requests.
      def resource
        Excon.new(url, options)
      end

      private :resource

      # Send a request to the server with the `
      def request(*args, &block)
        request = compile_request_params(*args, &block)
        log_request(request)
        resource.request(request)
      rescue Excon::Errors::BadRequest => ex
        raise ClientError, ex.response.body
      rescue Excon::Errors::Unauthorized => ex
        raise UnauthorizedError, ex.response.body
      rescue Excon::Errors::NotFound => ex
        raise NotFoundError, ex.response.body
      rescue Excon::Errors::Conflict => ex
        raise ConflictError, ex.response.body
      rescue Excon::Errors::InternalServerError => ex
        raise ServerError, ex.response.body
      rescue Excon::Errors::Timeout => ex
        raise TimeoutError, ex.message
      end

      def log_request(request)
        if Api.logger
          Api.logger.debug(
            [request[:method], request[:path], request[:query], request[:body]]
          )
        end
      end

      # Delegate all HTTP methods to the #request.
      [:get, :put, :post, :delete].each do |method|
        define_method(method) { |*args, &block| request(method, *args, &block) }
      end

      def to_s
        "Docker::Distribution::Connection { :url => #{url}, :options => #{options} }"
      end

      private
      # Given an HTTP method, path, optional query, extra options, and block,
      # compiles a request.
      def compile_request_params(http_method, path, query = nil, opts = nil, &block)
        query ||= {}
        opts ||= {}
        headers = opts.delete(:headers) || {}
        content_type = opts[:body].nil? ? 'text/plain' : 'application/json'
        user_agent = "bazilio91/docker-distribution-api #{Api::VERSION}"
        {
          :method => http_method,
          :path => "/v#{Api::API_VERSION}#{path}",
          :query => query,
          :headers => {'Content-Type' => content_type,
                       'User-Agent' => user_agent,
          }.merge(headers),
          :expects => (200..204).to_a << 301 << 304,
          :idempotent => http_method == :get,
          :request_block => block,
        }.merge(opts).reject { |_, v| v.nil? }
      end
    end
  end
end
