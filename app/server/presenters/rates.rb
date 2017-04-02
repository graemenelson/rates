module Server
  module Presenters
    class Rates

      CURRENCIES = [
        'EUR',
        'CHF',
        'GBP',
        'JPY',
        'AUD',
        'NZD',
        'USD',
        'CAD'
      ].sort.freeze

      attr_reader :currency, :rates

      def initialize(currency, rates)
        @currency = currency
        @rates    = rates
      end

      def as_json(opts = nil)
        {
          currency: currency,
          headers:  ["DATE"] + headers,
          rows:     rows
        }
      end

      private

      def headers
        @headers ||= CURRENCIES.select {|curr| curr != currency}
      end

      def rows
        rates.each_with_object([]) do |rate, results|
          row = headers.each_with_object([rate.date]) do |header, entry|
            entry.push(price_for_display(header, rate.prices[header]))
          end

          results.push(row)
        end
      end

      def price_for_display(header, price)
        return unless price

        if header == 'JPY'
          "%.2f" % price
        else
          "%.5f" % price
        end
      end
    end
  end
end
