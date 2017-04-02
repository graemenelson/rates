require 'spec_helper'

describe Rates::Fetch do
  subject { Rates::Fetch }

  describe 'with currency' do
    before { resetdb }

    it 'handles candles with no before'
    it 'handles candles with before'
    it 'handles no candles'
  end

  it 'fails with no currency' do
    i = subject.call
    refute i.success?
    i.error.must_match /currency is required/
  end
end
