require 'spec_helper'

describe Przelewy24::Ekspres::Client do
  it 'creates ekspres client' do
    expect { Przelewy24::Ekspres::Client.new('jan@kowalski.pl', 'password') }.not_to raise_error
  end
end
