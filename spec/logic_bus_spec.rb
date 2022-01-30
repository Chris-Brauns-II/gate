require "./lib/logic_bus"

RSpec.describe LogicBus do
  subject { described_class.new }

  describe ".consume_for" do
    it "returns events for the time" do
      e = LogicBusEvent.new(time: 100, value: false, wire: Wire.new(true))
      subject.push(e)

      expect(subject.consume_for(100)).to include(e)
    end
  end

  describe ".push" do
    it "adds a LogicBusEvent to the LogicBus" do
      e = LogicBusEvent.new(time: 0, value: false, wire: Wire.new(true))
      subject.push(e)

      expect(subject.bus).to include(e)
    end
  end
end