# Contains all knowledge for exporting formats

# # TYPE linode_cpu counter
# # HELP linode_cpu A counter of HTTP requests made
# linode_cpu{linode_id=""} 0.0
# linode_cpu{linode_id="1233"} 6.0

class CounterExporter

  def initialize(name, docstring)
    @name = name
    @docstring = docstring
    @values = {}
  end

  def increment(label)
    @values[timestamp] = { } if ! @values.key? timestamp
    @values[timestamp][label] = 0 if ! @values[timestamp].key? label

    @values[timestamp][label] += 1
  end

  def values 
    @values.to_s
  end

  def export
    lines = []
    lines << "# TYPE #{@name} counter"
    lines << "# HELP #{@name} #{@docstring}"
    lines.join("\r\n")
  end

  private
  def timestamp
    Time.now.strftime("%Y:%m:%d-%H")
  end

end