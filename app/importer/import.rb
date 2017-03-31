module Importer
  class Import
    include Interactor


    delegate :base,
             :date,
             to: :context

    def call
      context.fail!(error: 'base is required') unless base
      context.fail!(error: 'date is required') unless date

      import!
    end

    private

    def import!
      context.rates = Fixer::Api.rates(base: base, date: date)['rates'].map do |(curr,price)|
        Rate.create(base: base, date: date, quoted: curr, price: price)
      end
    end

  end
end
