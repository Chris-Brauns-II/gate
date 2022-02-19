class Circuit
  attr_reader :logic_bus

  def initialize(logic_bus:, logic_time:)
    @logic_bus = logic_bus
    @last_updated_time = -1

    logic_time.observe(self)
  end

  def update_time(time)
    events = logic_bus.consume_between(last_updated_time, time)

    wire_observers = events.map(&:wire).map(&:observers).flatten.uniq

    events.each do |lbe|
      lbe.wire.update(lbe.value)
    end

    wire_observers.each { |wo| wo.evaluate }

    last_updated_time = time
  end

  private

  attr_accessor :last_updated_time
end