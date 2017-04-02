require 'spec_helper'

describe Rates::Fetch do
  subject { Rates::Fetch }

  describe 'with currency' do
    before do
      resetdb

      ['2017-01-31', '2017-01-30', '2017-01-29'].each do |date|
        create(:rate, currency: 'EUR', date: date)
      end
    end

    it 'handles rates with no before' do
      i = subject.call(currency: 'EUR')
      assert i.success?
      i.rates.collect(&:date).collect(&:to_s).must_equal ['2017-01-31', '2017-01-30', '2017-01-29']
    end

    it 'handles rates with before' do
      i = subject.call(currency: 'EUR', before: '2017-01-30')
      assert i.success?
      i.rates.collect(&:date).collect(&:to_s).must_equal ['2017-01-29']
    end

    it 'handles no rates' do
      i = subject.call(currency: 'CAD')
      assert i.success?
      i.rates.must_be :empty?
    end
  end

  it 'fails with no currency' do
    i = subject.call
    refute i.success?
    i.error.must_match /currency is required/
  end
end
