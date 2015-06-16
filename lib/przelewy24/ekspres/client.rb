require 'savon'

module Przelewy24
  module Ekspres
    class Client
      def initialize(login, password)
        @login = login
        @password = password
      end

      def register_transfer(transaction)
        response = client.call(:register_transfer, message: {
          'authorizeIn' => authorization_object,
          'o_transactionIn' => transaction
        })

        Response.new(response.body[:register_transfer_response][:return])
      rescue Savon::SOAPFault => error
        raise InvalidAttributes
      end

      private

      def client
        @client ||= Savon::Client.new(wsdl: 'https://ekspres.przelewy24.pl/wsdl/pay/service_sandbox.php?wsdl')
      end

      def authorization_object
        {
          login: @login,
          pass: @password
        }
      end
    end
  end
end
