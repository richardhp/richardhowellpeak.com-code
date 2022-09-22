require 'sinatra'
require './lib/exporter'

# Load env
LINODE_API_KEY = ENV["LINODE_API_KEY"]

exporter = CounterExporter.new('linode_cpu', 'cpu usage on linode')

set :bind, '0.0.0.0'
set :port, 80

get '/metrics' do
  exporter.export
end

get '/:id' do
  exporter.increment(params["id"])
  "Data: #{exporter.values}"
end

