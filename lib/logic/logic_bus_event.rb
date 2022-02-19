class LogicBusEvent
  attr_reader :time, :value, :wire

  def initialize(time:, wire:, value:)
    @time = time
    @wire = wire
    @value = value
  end

  def ==(o)
    time == o.time &&
    wire == o.wire &&
    value == o.value
  end
end