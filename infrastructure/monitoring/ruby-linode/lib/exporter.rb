# Contains all knowledge for exporting formats

# # TYPE linode_cpu counter
# # HELP linode_cpu A counter of HTTP requests made
# linode_cpu{linode_id=""} 0.0
# linode_cpu{linode_id="1233"} 6.0

class CounterExporter

  def initialize(name, docstring, label_name)
    @name = name
    @docstring = docstring
    @label_name = label_name
    @values = {}
  end

  def increment(label)
    @values[label] = { } if ! @values.key? label
    @values[label][timestamp] = 0 if ! @values[label].key? timestamp

    @values[label][timestamp] += 1
  end

  def values 
    @values.to_s
  end

  def export
    lines = []
    lines << "# TYPE #{@name} counter"
    lines << "# HELP #{@name} #{@docstring}"
    @values.keys.each do |label|
      @values[label].keys.each do |tstamp|
        puts label
        lines << "#{@name}{#{@label_name}=\"#{label}\"} #{@values[label][timestamp].to_f} #{DateTime.strptime(tstamp, "%Y:%m:%d-%H").strftime("%s")}"
      end
    end
    puts lines.to_s
    lines.join("\r\n")
  end

  def export_styled
    "<pre style=\"word-wrap: break-word; white-space: pre-wrap;\">#{export}</pre>"
  end

  private
  def timestamp
    DateTime.now.strftime("%Y:%m:%d-%H")
  end

end