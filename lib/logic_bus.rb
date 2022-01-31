class LogicBus
  def bus
    @bus ||= []
  end

  def consume_for(time)
    bus.select { |lbe| lbe.time == time }
  end

  def for(time:, wire:)
    bus.detect { |lbe| lbe.time == time && lbe.wire == wire }
  end

  def max_time
    bus.map(&:time).max
  end

  def push(logic_bus_event)
    bus.push(logic_bus_event)

    self
  end

  def wires
    bus.map(&:wire).uniq.sort_by(&:name)
  end
end