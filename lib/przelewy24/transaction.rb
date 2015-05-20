module Przelewy24
  class Transaction
    attr_reader :session_id, :merchant_id, :amount, :crc, :description, :email, :signature,
      :url_return, :url_status, :wait_for_result, :currency, :country, :encoding,
      :client_name, :client_address, :client_zip, :client_city, :client_phone, :language,
      :method, :time_limit, :channel

    def initialize(data = {})
      @data ||= {}

      @session_id = data[:session_id] || generate_session_id
      @merchant_id = data[:merchant_id]
      @crc = data[:crc]
      @amount = data[:amount]
      @description = data[:description]
      @email = data[:email]
      @url_return = data[:url_return]
      @url_status = data[:url_status]
      @wait_for_result = data[:wait_for_result]
      @currency = data[:currency]
      @country = data[:country]
      @encoding = data[:encoding]
      @client_name = data[:client_name]
      @client_address = data[:client_address]
      @client_zip = data[:client_zip]
      @client_city = data[:client_city]
      @client_phone = data[:client_phone]
      @language = data[:language]
      @method = data[:method]
      @time_limit = data[:time_limit]
      @channel = data[:channel]

      @signature = calculate_signature
    end

    def to_data
      {
        p24_merchant_id: merchant_id,
        p24_pos_id: merchant_id,
        p24_session_id: session_id,
        p24_amount: amount,
        p24_currency: currency,
        p24_description: description,
        p24_email: email,
        p24_client: client_name,
        p24_address: client_address,
        p24_zip: client_zip,
        p24_city: client_city,
        p24_country: country,
        p24_phone: client_phone,
        p24_language: language,
        p24_method: method,
        p24_url_return: url_return,
        p24_url_status: url_status,
        p24_time_limit: time_limit,
        p24_wait_for_result: wait_for_result,
        p24_channel: channel,
        p24_sign: signature,
        p24_encoding: encoding,
        p24_api_version: '3.2'
      }
    end

    private

    def calculate_signature
      @signature = Digest::MD5.hexdigest([
        session_id,
        merchant_id,
        amount,
        currency,
        crc
      ].join('|'))
    end

    def generate_session_id
      Time.zone.now.to_i
    end
  end
end
