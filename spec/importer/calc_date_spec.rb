require 'spec_helper'

describe Importer::CalcDate do
  subject { Importer::CalcDate }
  before  { resetdb }

  it 'handles no recent rate by loading default date and not increment by one day' do
    i = subject.call(currency: 'USD')
    assert i.success?
    i.date.must_equal '2010-01-01'
  end

  it 'handles recent rate by loading date and increment by one day' do
    create(:rate, base: 'USD', quoted: 'EUR', date: '2017-03-03')
    i = subject.call(currency: 'USD')
    assert i.success?
    i.date.must_equal '2017-03-04'
  end

  it 'handles existing date by increment by one day' do
    i = subject.call(currency: 'USD', date: '2017-03-04')
    assert i.success?
    i.date.must_equal '2017-03-05'
  end

  it 'fails with missing currency' do
    i = subject.call
    refute i.success?
    i.error.must_match /currency is required/
  end
end
