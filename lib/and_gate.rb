class AndGate
  attr_reader :a, :b, :event_bus, :latency, :output_wire, :time

  def initialize(a:, b:, event_bus:, output_wire:, time:, latency: 100)
    @a = a
    @b = b
    @event_bus = event_bus
    @output_wire = output_wire
    @time = time

    @latency = latency

    a.observe(self)
    b.observe(self)
  end

  def evaluate
    new_value = a.value && b.value

    if new_value != output_wire.value
      event_bus.push(
        LogicBusEvent.new(
          time: time.current + latency,
          wire: output_wire,
          value: new_value
        )
      )
    end
  end

  def inspect
    event_bus.to_s
  end
end