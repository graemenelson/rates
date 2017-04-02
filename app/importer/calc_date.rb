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
      # FIXME: skip weekends, since forex is closed

      context.date = increment_date || load_and_increment_date || default
    end

    def increment_date
      increment(context.date)
    end

    def load_and_increment_date
      rate = Rate.where(currency: currency).order(date: :desc).first
      increment(rate.try(:date))
    end

    def increment(date)
      return unless date
      date = date.is_a?(Date) ? date : Date.parse(date)
      skip_weekend(date.tomorrow).to_s
    end

    def skip_weekend(date)
      return date + 2.day if date.saturday?
      return date + 1.day if date.sunday?
      date
    end

    def default
      skip_weekend(Date.today - 30.days)
    end
  end
end
