require 'cuba'
require 'cuba/render'
require 'erb'

require_relative 'server/presenters/rates'

Cuba.use Rack::Static, :urls => ["/images", "/js", "/css"], :root => 'public'

Cuba.plugin Cuba::Render

Cuba.settings[:render][:views] = "./app/server/views/"

Cuba.define do

  on get do
    on root do
      res.write partial('rates', {})
    end

    on "rates/:currency.json" do |currency|
      rates     = Rates::Fetch.call(currency: currency).rates
      presenter = Server::Presenters::Rates.new(currency, rates)

      res.headers["Content-Type"] = "application/json; charset=utf-8"
      res.write(presenter.to_json)
    end
  end
end
