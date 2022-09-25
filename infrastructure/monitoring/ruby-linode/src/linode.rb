require './src/prometheus'

require 'async/http/internet'
require 'json'

LINODE_PERSONAL_ACCESS_TOKEN = ENV["LINODE_PERSONAL_ACCESS_TOKEN"]
SAMPLING_INTERVAL = 10
BASE_URL = "https://api.linode.com/v4/linode"

def instances_url
  "#{BASE_URL}/instances"
end

def stats_url(linode_id)
  "#{BASE_URL}/instances/#{linode_id}/stats"
end

def poll_linode

  Async do |task|
    internet = Async::HTTP::Internet.new

    while true do
      puts "Sampling Linode"
      # Make a new internet:
      headers = [['accept', 'application/json'], ['Authorization', "Bearer #{LINODE_PERSONAL_ACCESS_TOKEN}"]]
      response = internet.get(instances_url, headers)
      puts JSON.parse(response.read)
    end

  ensure
    internet.close
  end
end

