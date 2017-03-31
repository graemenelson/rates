module Importer
  class Seed
    include Interactor

    CURRENCIES = [
      'EUR',
      'CHF',
      'GBP',
      'JPY',
      'AUD',
      'NZD',
      'USD',
      'CAD'
    ].freeze

    def call
      CURRENCIES.each {|currency| Importer::Job.call(currency: currency)}
    end
  end
end
