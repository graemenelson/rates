require 'spec_helper'

describe Fixer::Api do
  subject { Fixer::Api }

  describe 'rates' do
    let(:response) do
      # NOTE: using string hash keys to make comparision easier in the tests
      {
        "base" => "EUR",
        "date" => "2017-03-28",
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
    it 'handles defaults' do
      WebMock.stub_request(:get, "#{fixer_endpoint}/latest?base=EUR")
             .to_return(fixer_response_headers.merge(status: 200, body: JSON.generate(response)))

      subject.rates.must_equal response
    end

    it 'handles custom base and date' do
      WebMock.stub_request(:get, "#{fixer_endpoint}/2017-03-10?base=USD")
             .to_return(fixer_response_headers.merge(status: 200, body: JSON.generate(response)))

      subject.rates(base: 'USD', date: '2017-03-10').must_equal response
    end

  end
end
