require 'spec_helper'

describe Importer::CalcDate do
  subject { Importer::CalcDate }
  before  { resetdb }

  it 'handles recent rate by loading date and increment by one day' do
    create(:rate, currency: 'USD', prices: {}, date: '2017-03-02')
    i = subject.call(currency: 'USD')
    assert i.success?
    i.date.must_equal '2017-03-03'
  end

  it 'handles existing date by increment by one day' do
    i = subject.call(currency: 'USD', date: '2017-03-02')
    assert i.success?
    i.date.must_equal '2017-03-03'
  end

  it 'handles skipping weekend when next date fails on saturday (since forex market is closed)' do
    i = subject.call(currency: 'USD', date: '2017-03-03')
    assert i.success?
    i.date.must_equal '2017-03-06'
  end

  it 'fails with missing currency' do
    i = subject.call
    refute i.success?
    i.error.must_match /currency is required/
  end
end
