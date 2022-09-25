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

class HttpClient
  def initialize
    @http_client = Async::HTTP::Internet.new
    @headers = [['accept', 'application/json'], ['Authorization', "Bearer #{LINODE_PERSONAL_ACCESS_TOKEN}"]]
  end

  def get(url)
    response = @http_client.get(url, @headers)
    JSON.parse(response.read)
  end

  def close
    @http_client.close
  end
end

# This will keep trying to get them until it works
def get_linode_ids(task, http_client)
  linode_ids = nil
  while linode_ids.nil? do
    response = http_client.get(instances_url)
    if response.has_key? 'data'
      linode_ids = response['data'].map { |linode| linode['id'] }
      puts "Got ids " + linode_ids.to_s
    else
      puts "Error fetching IDs"
      task.sleep 10
    end
  end
  linode_ids
end

# Constantly get the data
def poll_linode(prometheus)
  
  http_client = HttpClient.new

  Async do |task|
    
    # Fetch linodes
    linode_ids = get_linode_ids(task, http_client)
    
    while true do
      puts "Sampling Linode"

      linode_ids.each do |linode_id|
        stats = http_client.get(stats_url(linode_id))
        prometheus.linode_cpu.set(stats['data']['cpu'].last.last, labels: { linode_id: linode_id })
      end

      task.sleep SAMPLING_INTERVAL
    end

  ensure
    http_client.close
  end
end

