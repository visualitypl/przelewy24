module Przelewy24
  class Response
    attr_reader :attributes

    def initialize(http_response)
      puts http_response.body
      @attributes = Rack::Utils.parse_nested_query(http_response.body)
    end

    def success?
      attributes['error'] == '0'
    end
  end
end
