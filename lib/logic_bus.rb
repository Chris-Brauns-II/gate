class LogicBus
  def bus
    @bus ||= []
  end

  def consume_for(time)
    bus.select { |lbe| lbe.time == time }
  end

  def push(logic_bus_event)
    bus.push(logic_bus_event)

    self
  end
end