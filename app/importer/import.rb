module Importer
  class Import
    include Interactor

    delegate :currency,
             :date,
             to: :context

    def call
      context.fail!(error: 'currency is required') unless currency
      context.fail!(error: 'date is required') unless date

      import!
    end

    private

    def import!
      response = Fixer::Api.rates(base: currency, date: date)

      context.rates = response['rates'].map do |(curr,price)|
        # NOTE: using response date, since fixer is completely happy to send you today's
        # rates if you use a date way in the future.  Using response date will force
        # Rate.create to complain because unique constraints
        Rate.create(base: currency, date: response['date'], quoted: curr, price: price)
      end
    end

  end
end
