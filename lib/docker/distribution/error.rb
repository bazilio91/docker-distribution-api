module Docker
  module Distribution
    # This module holds the Errors for the gem.
    module Error

      # The default error. It's never actually raised, but can be used to catch all
      # gem-specific errors that are thrown as they all subclass from this.
      class DockerDistributionError < StandardError;
      end

      # Raised when invalid arguments are passed to a method.
      class ArgumentError < DockerDistributionError;
      end

      # Raised when a request returns a 400.
      class ClientError < DockerDistributionError;
      end

      # Raised when a request returns a 401.
      class UnauthorizedError < DockerDistributionError;
      end

      # Raised when a request returns a 404.
      class NotFoundError < DockerDistributionError;
      end

      # Raised when a request returns a 409.
      class ConflictError < DockerDistributionError;
      end

      # Raised when a request returns a 500.
      class ServerError < DockerDistributionError;
      end

      # Raised when there is an unexpected response code / body.
      class UnexpectedResponseError < DockerDistributionError;
      end

      # Raised when there is an incompatible version of Docker.
      class VersionError < DockerDistributionError;
      end

      # Raised when a request times out.
      class TimeoutError < DockerDistributionError;
      end

      # Raised when login fails.
      class AuthenticationError < DockerDistributionError;
      end

      # Raised when an IO action fails.
      class IOError < DockerDistributionError;
      end
    end
  end
end