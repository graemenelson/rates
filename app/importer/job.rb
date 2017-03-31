module Importer
  class Job < Que::Job
    include Interactor
    @queue = 'importer'

    # Using a class to act as the interactor, since the interactor and que gem
    # conflict with each other for the #run method.
    class Enqueue
      include Interactor

      def call
        context.fail!(error: "currency is required") unless currency
        context.fail!(error: "job already exists for '#{currency}'") if job_exists?

        Job.enqueue(context.to_h)
      end

      private

      def currency
        context.currency
      end

      def job_exists?
        QueJob.where(job_class: Job.to_s).to_a.find do |job|
          job.args.first['currency'] == currency
        end
      end
    end

    def self.call(opts = {})
      Enqueue.call(opts)
    end

    def run(args)
      puts args.inspect
    end

  end
end
