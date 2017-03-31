require 'spec_helper'

describe Importer::Job do
  subject { Importer::Job }
  before  { resetdb }

  describe '#call' do
    it 'queues job with with new currency' do
      i = subject.call(currency: 'USD')
      assert i.success?

      job = QueJob.for(subject.to_s).first
      job.args.first.symbolize_keys.must_equal({currency: 'USD'})
    end

    it 'fails with existing job for currency' do
      subject.call(currency: 'USD')

      i = subject.call(currency: 'USD')
      refute i.success?
      i.error.must_match /job already exists for 'USD'/
    end

    it 'fails with missing currency' do
      i = subject.call
      refute i.success?
      i.error.must_match /currency is required/
    end
  end

  describe '#run' do
    it 'destroys job and requeues' do
      subject.call({currency: 'USD'})
      orig_job = QueJob.for(subject.to_s).first

      Importer::Organizer.stub(:call, OpenStruct.new(success?: true)) do
        Que::Job.work('importer')
      end

      new_job = QueJob.for(subject.to_s).first
      new_job.id.wont_equal orig_job.id
    end
  end
end
