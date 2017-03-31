require 'spec_helper'

describe Importer::Seed do
  subject { Importer::Seed }
  before  { resetdb }

  it 'loads all the import jobs for the 8 major currencies' do
    i = subject.call
    assert i.success?
    QueJob.count.must_equal 8
  end

  it 'loads missing import jobs' do
    Importer::Job.call(currency: 'EUR')
    assert QueJob.count.must_equal 1

    i = subject.call
    assert i.success?
    QueJob.count.must_equal 8
  end

  it 'does not reload import jobs if they already exist' do
    subject.call
    QueJob.count.must_equal 8

    i = subject.call
    assert i.success?
    QueJob.count.must_equal 8
  end

end
