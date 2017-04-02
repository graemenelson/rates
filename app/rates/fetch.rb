module Rates
  class Fetch
    include Interactor

    delegate :currency,
             to: :context

    def call
      context.fail!(error: 'currency is required') unless currency
    end
  end
end
