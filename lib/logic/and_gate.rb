class AndGate
  attr_reader :a, :b, :logic_bus, :latency, :output_wire, :time

  def initialize(a:, b:, logic_bus:, output_wire:, time:, latency: 100)
    @a = a
    @b = b
    @logic_bus = logic_bus
    @output_wire = output_wire
    @time = time

    @latency = latency

    a.observe(self)
    b.observe(self)
  end

  def evaluate
    new_value = a.value && b.value

    if new_value != output_wire.value
      logic_bus.push(
        LogicBusEvent.new(
          time: time.current + latency,
          wire: output_wire,
          value: new_value
        )
      )
    end
  end

  def inspect
    logic_bus.to_s
  end
end