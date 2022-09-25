require 'sinatra'
require 'prometheus/client'
require 'prometheus/middleware/exporter'

# Load env
LINODE_API_KEY = ENV["LINODE_API_KEY"]

prometheus = Prometheus::Client.registry

linode_cpu = Prometheus::Client::Gauge.new(:linode_cpu, docstring: 'cpu usage on linode', labels: [:linode_id])
api_calls = Prometheus::Client::Counter.new(:api_calls, docstring: 'A counter of api calls', labels: [:endpoint])
prometheus.register(linode_cpu)
prometheus.register(api_calls)

set :bind, '0.0.0.0'
set :port, 80

use Prometheus::Middleware::Exporter

get '/cpu/:id/:value' do
  # set a value
  linode_cpu.set(params['value'].to_f, labels: { linode_id: params['id'] })

  # gauge.get(labels: { room: 'kitchen' })
  # gauge.increment(labels: { room: 'kitchen' })
  # gauge.decrement(by: 5, labels: { room: 'kitchen' })
  
  "Data: #{params['value']}"
end

get '/api/:id' do
  # set a value
  api_calls.increment(by: 1, labels: { endpoint: params['id'] })

  "Data: #{params['value']}"
end
