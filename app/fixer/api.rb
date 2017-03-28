require 'jsonclient'

module Fixer
  class Api

    def self.endpoint
      ENV['FIXER_API_ENDPOINT']
    end

    def self.connection_pool
      @connection_pool ||= ConnectionPool.new(size: 2, timeout: 5) { self.new(self.endpoint) }
    end

    def self.rates(options = {})
      connection_pool.with do |conn|
        conn.rates(options)
      end
    end

    attr_reader :endpoint

    def initialize(endpoint)
      @endpoint = endpoint
    end

    def rates(options)
      base, date = {base: 'EUR', date: 'latest'}.merge(options).values_at(:base, :date)
      get("#{endpoint}/#{date}", {base: base})
    end

    private

    def get(url, params = {}, status = 200)
      res = api.get(url, params)
      raise_error(res) unless res.status == status
      res.content
    end

    def api
      @api ||= build_api
    end

    def build_api
      JSONClient.new(base_url: endpoint)
    end

    def raise_error(res)
      message = res.content['message']
      fail "Unable to process fixer.io request due to: #{res.status} - #{res.reason}\n\n#{message}"
    end
  end
end
