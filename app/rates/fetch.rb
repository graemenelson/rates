module Rates
  class Fetch
    include Interactor

    delegate :currency,
             :before,
             to: :context

    def call
      context.fail!(error: 'currency is required') unless currency

      fetch!
    end

    private

    def fetch!
      query = Rate.where(currency: currency)
      query = query.before(before) if before
      context.rates = query.order(date: :desc)
    end
  end
end
