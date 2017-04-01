require 'spec_helper'

describe Importer::Import do
  subject { Importer::Import }

  describe 'with currency and date' do
    before { resetdb }
    let(:response) do
      {
        "base" => "USD",
        "date" => "2017-03-01",
        "rates" => {
          "AUD" => 1.4281,
          "CAD" => 1.4546,
          "CHF" => 1.0693,
          "GBP" => 0.86455,
          "JPY" => 119.84,
          "NZD" => 1.5454,
          "USD" => 1.0859
        }
      }
    end

    it 'handles rates found' do
      WebMock.stub_request(:get, "#{fixer_endpoint}/2017-03-01?base=USD")
             .to_return(fixer_response_headers.merge(status: 200, body: JSON.generate(response)))

      interactor = subject.call(currency: 'USD', date: '2017-03-01')
      assert interactor.success?

      Rate.all.count.must_equal 7

      rates = interactor.rates
      response['rates'].each_with_index do |(currency, price), idx|
        rates[idx].base.must_equal 'USD'
        rates[idx].date.must_equal Date.parse('2017-03-01')
        rates[idx].quoted.must_equal currency
        rates[idx].price.must_equal price
      end
    end

    it 'handles no rates found' do
      WebMock.stub_request(:get, "#{fixer_endpoint}/2017-03-01?base=USD")
             .to_return(fixer_response_headers.merge(status: 200, body: JSON.generate(response.merge('rates' => []))))

      interactor = subject.call(currency: 'USD', date: '2017-03-01')
      assert interactor.success?
      interactor.rates.must_be :empty?
    end

    it 'raises unique constraint issue when existing base, quoted, date exist' do
      WebMock.stub_request(:get, "#{fixer_endpoint}/2017-03-01?base=USD")
             .to_return(fixer_response_headers.merge(status: 200, body: JSON.generate(response)))

      create(:rate, base: 'USD', quoted: 'AUD', date: '2017-03-01')

      proc {
        subject.call(currency: 'USD', date: '2017-03-01')
      }.must_raise ActiveRecord::RecordNotUnique
    end
  end

  it 'fails with missing currency' do
    interactor = subject.call(date: '2017-03-01')
    refute interactor.success?
    interactor.error.must_match /currency is required/
  end

  it 'fails with missing date' do
    interactor = subject.call(currency: 'USD')
    refute interactor.success?
    interactor.error.must_match /date is required/
  end
end
