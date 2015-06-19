require 'net/http'
require 'digest'

module Przelewy24
  class Client
    attr_reader :merchant_id, :pos_id, :crc, :gateway_url

    def initialize(merchant_id, pos_id, crc, mode = :sandbox)
      @merchant_id = merchant_id
      @pos_id = pos_id
      @crc = crc

      if mode == :production
        @gateway_url = 'secure.przelewy24.pl'
      elsif mode == :sandbox
        @gateway_url = 'sandbox.przelewy24.pl'
      elsif mode == :sandbox2
        @gateway_url = 'sandbox2.przelewy24.pl'
      else
        raise InvalidGatewayUrl
      end
    end

    def test_connection
      signature = Digest::MD5.hexdigest("#{merchant_id}|#{crc}")

      connection = Net::HTTP.new(gateway_url, 443)
      connection.use_ssl = true

      response = connection.start do |http|
        post = Net::HTTP::Post.new('/testConnection')
        post.set_form_data(p24_merchant_id: merchant_id, p24_pos_id: merchant_id, p24_sign: signature)
        http.request(post)
      end

      HttpResponse.new(response)
    end

    def create_transaction(data = {})
      Transaction.new(data.reverse_merge(merchant_id: merchant_id, pos_id: pos_id, crc: crc))
    end

    def register_transaction(transaction)
      connection = Net::HTTP.new(gateway_url, 443)
      connection.use_ssl = true

      response = connection.start do |http|
        post = Net::HTTP::Post.new('/trnRegister')
        post.set_form_data(transaction.to_data)
        http.request(post)
      end

      HttpResponse.new(response)
    end

    def verify_transaction(data = {})
      connection = Net::HTTP.new(gateway_url, 443)
      connection.use_ssl = true

      signature = Digest::MD5.hexdigest([
        data['p24_session_id'],
        data['p24_order_id'],
        data['p24_amount'],
        data['p24_currency'],
        crc
      ].join('|'))

      response = connection.start do |http|
        post = Net::HTTP::Post.new('/trnVerify')
        post.set_form_data(data.merge('p24_sign' => signature))
        http.request(post)
      end

      HttpResponse.new(response)
    end
  end
end
