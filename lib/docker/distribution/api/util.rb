module Docker
  module Distribution
    module Api
      module Util
        require 'json'
        module_function

        def parse_json(body)
          JSON.parse(body) unless body.nil? || body.empty? || (body == 'null')
        rescue JSON::ParserError => ex
          raise UnexpectedResponseError, ex.message
        end
      end
    end
  end
end
