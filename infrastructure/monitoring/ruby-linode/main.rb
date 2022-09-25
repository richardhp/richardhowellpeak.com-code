require 'sinatra'
require './src/exporter'

# Load env
LINODE_API_KEY = ENV["LINODE_API_KEY"]

exporter = CounterExporter.new('linode_cpu', 'cpu usage on linode', 'linode_id')

set :bind, '0.0.0.0'
set :port, 80

get '/metrics' do
  puts exporter.export.to_s
  exporter.export
end

get '/metrics/styled' do
  exporter.export_styled
end

get '/favicon.ico' do 
end

get '/:id' do
  exporter.increment(params["id"])
  "Data: #{exporter.values}"
end

