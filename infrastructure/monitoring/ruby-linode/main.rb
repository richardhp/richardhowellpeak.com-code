require 'async'
require './src/prometheus'
require './src/linode'
require './src/metrics-server'

# This is quite convoluted but it works.  We wrap everything inside an EventLoop
Async do |task|
  # Start the polling loop
  poll_linode
  # Nest Sinatra inside an async task, so we can continue after server has started
  Async do |t| 
    MetricsServer.run!
  end
  # Override the signal traps done by sinatra so we can force the application to quite at the top level
  Signal.trap('INT') do |sig|
    puts "Received Signal #{sig}"
    exit
  end
end
