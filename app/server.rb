require 'cuba'
require 'cuba/render'
require 'erb'

Cuba.use Rack::Static, :urls => ["/images", "/js", "/css"], :root => 'public'

Cuba.plugin Cuba::Render

Cuba.settings[:render][:views] = "./app/server/views/"

Cuba.define do

  on get do
    on root do
      res.write partial('rates', {})
    end
  end
end
