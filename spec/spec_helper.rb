ENV['RATES_ENV'] = 'test'
require './config/environment'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
require 'webmock/minitest'

class Minitest::Spec
  let(:fixer_endpoint) { Fixer::Api.endpoint }

  def fixer_response_headers
    { headers: {"Content-Type" => "application/json; charset=utf-8"} }
  end
end
