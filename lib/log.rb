class Log
  attr_reader :event_bus, :length

  def initialize(event_bus, length: 5)
    @event_bus = event_bus
    @length = length
  end

  def log
    wires = event_bus.bus.map(&:wire).uniq.sort_by(&:name)

    lines = wires.map { |w| build_line(w) }

    output = ""
    lines.each do |l|
      output += l + "\n\n"
    end

    output
  end

  private

  def build_line(wire)
    line = "#{wire.name}: "

    max_time = event_bus.bus.map(&:time).max + 400
    wire_events = event_bus.bus.select { |lbe| lbe.wire == wire }.sort_by(&:time)
    counter = 0
    current_wire_value = false

    (0..max_time).step(100) do |counter|
      wire_event_for_current_time = wire_events.detect { |we| we.time == counter }

      if !wire_event_for_current_time.nil?
        current_wire_value = wire_event_for_current_time.value
      end

      output = current_wire_value == true ? "‾" * length : "_" * length
      line += output
    end

    line
  end
end