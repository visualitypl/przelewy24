module Przelewy24
  class HttpResponse
    attr_reader :attributes

    def initialize(http_response)
      @attributes = Rack::Utils.parse_nested_query(http_response.body)
    end

    def success?
      attributes['error'] == '0'
    end
  end
end
