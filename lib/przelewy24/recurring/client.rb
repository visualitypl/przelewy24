module Przelewy24
  module Recurring
    class Client
      def initialize(login, password, mode = :sandbox)
        @login = login
        @password = password

        if mode == :production
          @wsdl = 'https://secure.przelewy24.pl/external/wsdl/charge_card_service.php?wsdl'
        elsif mode == :sandbox
          @wsdl = 'https://sandbox2.przelewy24.pl/external/wsdl/charge_card_service.php?wsdl'
        else
          raise InvalidGatewayUrl
        end
      end

      def test_access
        response = client.call(:test_access, message: {
          login: @login,
          pass: @password
        })

        response[:test_access_response][:return]
      end

      def get_transaction_reference(order_id)
        response = client.call(:get_transaction_reference, message: {
          login: @login,
          pass: @password,
          orderId: order_id
        })

        SoapResponse.new(response.body[:get_transaction_reference_response][:return])
      end

      def charge_card(data = {})
        response = client.call(:charge_card, message: {
          login: @login,
          pass: @password,
          refid: data[:ref_id],
          amount: data[:amount],
          currency: data[:currency],
          sessionId: data[:session_id],
          client: data[:client],
          description: data[:description],
          email: data[:email]
        })

        SoapResponse.new(response.body[:charge_card_response][:return])
      end

      private

      def client
        @client ||= Savon::Client.new(wsdl: @wsdl)
      end
    end
  end
end
