require 'spec_helper'

describe Przelewy24::Client do
  it 'raises exception on invalid gateway mode' do
    expect { Przelewy24::Client.new('xxx', 'xxx', 'xxx', :test) }.to raise_error(Przelewy24::InvalidGatewayUrl)
  end
end
