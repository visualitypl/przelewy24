module Przelewy24
  class Transaction
    attr_reader :session_id, :merchant_id, :amount, :crc, :description, :email, :signature

    def initialize(data = {})
      @data ||= {}

      @session_id = data[:session_id] || generate_session_id
      @merchant_id = data[:merchant_id]
      @crc = data[:crc]
      @amount = data[:amount]
      @description = data[:description]
      @email = data[:email]
      @signature = calculate_signature
    end

    def to_data
      {
        p24_merchant_id: merchant_id,
        p24_pos_id: merchant_id,
        p24_session_id: session_id,
        p24_amount: amount,
        p24_currency: 'PLN',
        p24_description: description,
        p24_email: email,
        p24_country: 'PL',
        p24_url_return: 'http://54e3607b.ngrok.com/report',
        p24_url_status: 'http://54e3607b.ngrok.com/report',
        p24_wait_for_result: '1',
        p24_sign: signature,
        p24_encoding: 'UTF-8',
        p24_api_version: '3.2'
      }
    end

    private

    def calculate_signature
      @signature = Digest::MD5.hexdigest([
        session_id,
        merchant_id,
        amount,
        'PLN',
        crc
      ].join('|'))
    end

    def generate_session_id
      Time.zone.now.to_i
    end
  end
end
