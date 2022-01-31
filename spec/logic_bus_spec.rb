require "./lib/logic_bus"
require "./lib/logic_bus_event"
require "./lib/wire"

RSpec.describe LogicBus do
  subject { described_class.new }

  describe ".consume_for" do
    it "returns events for the time" do
      e = LogicBusEvent.new(time: 100, value: false, wire: Wire.new(true))
      subject.push(e)

      expect(subject.consume_for(100)).to include(e)
    end
  end

  describe ".for" do
    it "returns the events for the wire and time" do
      desired_wire = Wire.new(true)
      desired_event = LogicBusEvent.new(time: 300, value: false, wire: desired_wire)

      subject
        .push(desired_event)
        .push(LogicBusEvent.new(time: 300, value: false, wire: Wire.new(true)))
        .push(LogicBusEvent.new(time: 100, value: false, wire: desired_wire))

      expect(subject.for(time: 300, wire: desired_wire)).to eq(desired_event)
    end
  end

  describe ".max_time" do
    it "returns the max time" do
      subject
        .push(LogicBusEvent.new(time: 300, value: false, wire: Wire.new(true)))
        .push(LogicBusEvent.new(time: 500, value: false, wire: Wire.new(true)))
        .push(LogicBusEvent.new(time: 100, value: false, wire: Wire.new(true)))

      expect(subject.max_time).to eq(500)
    end
  end

  describe ".push" do
    it "adds a LogicBusEvent to the LogicBus" do
      e = LogicBusEvent.new(time: 0, value: false, wire: Wire.new(true))
      subject.push(e)

      expect(subject.bus).to include(e)
    end
  end

  describe ".wires" do
    it "returns the wires" do
      wire = Wire.new(true)
      e = LogicBusEvent.new(time: 0, value: false, wire: wire)
      subject.push(e)

      expect(subject.wires).to contain_exactly(wire)
    end
  end
end