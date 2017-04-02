require 'spec_helper'
require './app/server'

describe Server::Presenters::Rates do
  subject { Server::Presenters::Rates }

  describe 'to_json' do
    let(:currency) { 'EUR' }
    let(:headers) { ['CHF','GBP','JPY','AUD','NZD','USD','CAD'].sort }
    let(:rates) do
      [
        build(:rate, currency: currency, date: '2017-01-31', prices: {USD: 1.03456, CAD: 1.07893, NOK: 1.09999}),
        build(:rate, currency: currency, date: '2017-01-30', prices: {USD: 1.03543, CAD: 1.08000})
      ]
    end

    it 'renders appropriate json for the major currencies' do
      presenter = subject.new(currency, rates)
      assert_equal presenter.to_json,
                   JSON.generate({currency: currency,
                                  headers:  ["DATE"] + headers,
                                  rows:     [
                                    ['2017-01-31', nil, '1.07893', nil, nil, nil, nil, '1.03456'],
                                    ['2017-01-30', nil, '1.08000', nil, nil, nil, nil, '1.03543']
                                  ]})
    end
  end
end
