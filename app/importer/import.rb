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
      context.rates = Fixer::Api.rates(base: currency, date: date)['rates'].map do |(curr,price)|
        Rate.create(base: currency, date: date, quoted: curr, price: price)
      end
    end

  end
end
