require 'sinatra/base'

class MetricsServer < Sinatra::Base
  disable :traps

  set :bind, '0.0.0.0'
  set :port, ENV['PORT'] || 80
  
  use Prometheus::Middleware::Exporter
end

