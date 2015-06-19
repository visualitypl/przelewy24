module Przelewy24
  class SoapResponse
    def initialize(savon_response)
      @result = savon_response[:result]
      @error = savon_response[:error]
    end

    def success?
      @error[:error_code] == '0'
    end

    def result
      @result
    end

    def error
      @error
    end
  end
end
