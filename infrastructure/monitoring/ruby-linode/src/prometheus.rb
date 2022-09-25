require 'prometheus/client'
require 'prometheus/middleware/exporter'


class PrometheusMetrics

  def initialize
    @prometheus = Prometheus::Client.registry
    @linode_cpu_gauge = Prometheus::Client::Gauge.new(:linode_cpu, docstring: 'cpu usage on linode', labels: [:linode_id])
    # api_calls = Prometheus::Client::Counter.new(:api_calls, docstring: 'A counter of api calls', labels: [:endpoint])
    @prometheus.register(@linode_cpu_gauge)
    # prometheus.register(api_calls)
  end
  
  def linode_cpu
    @linode_cpu_gauge
  end
end
