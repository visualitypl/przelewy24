module Przelewy24
  module Ekspres
    class Response
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
    end
  end
end
