module Importer
  class Fetch
    include Interactor


    delegate :base,
             :date,
             to: :context

    def call
      context.fail!(error: 'base is required') unless base
      context.fail!(error: 'date is required') unless date

      fetch!
    end

    private

    def fetch!
      context.rates = rates_from_fixer
    end

    def rates_from_fixer
      Fixer::Api.rates(base: base, date: date)['rates'].map do |(curr,price)|
        Rate.new(base: base, date: date, quoted: curr, price: price)
      end
    end
  end
end
