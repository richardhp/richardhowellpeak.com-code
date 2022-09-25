
require 'sinatra'
require 'prometheus/client'
require 'prometheus/middleware/exporter'


# returns a default registry
prometheus = Prometheus::Client.registry

# create a new counter metric
linode_cpu = Prometheus::Client::Counter.new(:linode_cpu, docstring: 'A counter of linode CPU usage', labels: [:linode_id])
# register the metric
prometheus.register(linode_cpu)

# start using the counter
linode_cpu.increment(by: 1, labels: {  linode_id: 'abc' })

use Prometheus::Middleware::Exporter

get '/:id' do
  linode_cpu.increment(by: 1, labels: {  linode_id: params["id"] })
end

