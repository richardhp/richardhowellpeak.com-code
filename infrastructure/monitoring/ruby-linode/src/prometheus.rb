require 'prometheus/client'
require 'prometheus/middleware/exporter'

prometheus = Prometheus::Client.registry

linode_cpu = Prometheus::Client::Gauge.new(:linode_cpu, docstring: 'cpu usage on linode', labels: [:linode_id])
api_calls = Prometheus::Client::Counter.new(:api_calls, docstring: 'A counter of api calls', labels: [:endpoint])
prometheus.register(linode_cpu)
prometheus.register(api_calls)