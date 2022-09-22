
require 'sinatra'
require 'prometheus/client'
require 'prometheus/middleware/exporter'


# returns a default registry
prometheus = Prometheus::Client.registry

# create a new counter metric
http_requests = Prometheus::Client::Counter.new(:http_requests, docstring: 'A counter of HTTP requests made')
# register the metric
prometheus.register(http_requests)

# start using the counter
http_requests.increment

use Prometheus::Middleware::Exporter
