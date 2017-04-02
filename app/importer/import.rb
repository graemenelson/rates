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

      unless response['rates'].empty?
        context.rate = Rate.create(currency: currency,
                                   prices: response['rates'],
                                   date: response['date'])
       end
    end

  end
end
