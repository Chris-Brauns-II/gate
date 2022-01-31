class SignalLog
  def initialize(event_bus, time:, length: 5, &block)
    @event_bus = event_bus
    @length = length
    @time = time
    @time_callback = block

    @time.observe(self)
  end

  def update_time(time)
    return unless time % 100 == 0

    log.tap { |l| time_callback.call(l) }
  end

  def log
    wires = event_bus.wires

    lines = wires.map { |w| build_line(w) }

    output = ""
    lines.each do |l|
      output += l + "\n\n"
    end

    output
  end

  private

  attr_reader :event_bus, :length, :time, :time_callback

  def build_line(wire)
    line = "#{wire.name}: "

    current_wire_value = false

    (0..(time.current)).step(100) do |counter|
      wire_event_for_current_time = event_bus.for(wire: wire, time: counter)

      if !wire_event_for_current_time.nil?
        current_wire_value = wire_event_for_current_time.value
      end

      line += current_wire_value == true ? "‾" * length : "_" * length
    end

    line
  end
end