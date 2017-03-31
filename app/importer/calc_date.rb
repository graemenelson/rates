module Importer
  class CalcDate
    include Interactor

    delegate :currency, to: :context

    def call
      context.fail!(error: 'currency is required') unless currency

      calc_date!
    end

    private

    def calc_date!
      # NOTE: could have easily broke these out into their own interactors
      # and have CalcDate be an Organizer. Decided to keep here since I
      # didn't really see any benefit to breaking it out.
      context.date = increment_date || load_and_increment_date || default
    end

    def increment_date
      increment(context.date)
    end

    def load_and_increment_date
      rate = Rate.where(base: currency).order(date: :desc).first
      increment(rate.try(:date))
    end

    def increment(date)
      return unless date
      date = date.is_a?(Date) ? date : Date.parse(date)
      date.tomorrow.to_s
    end

    def default
      '2010-01-01'
    end
  end
end
