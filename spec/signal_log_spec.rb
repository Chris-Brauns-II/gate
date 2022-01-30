require "spec_helper"

require "./lib/signal_log"
require "./lib/logic_bus"
require "./lib/logic_bus_event"
require "./lib/wire"

RSpec.describe SignalLog do
  subject { described_class.new(event_bus, length: 1) }

  describe ".log" do
    let(:event_bus) do
      a = Wire.new(name: "A")
      b = Wire.new(name: "B")
      c = Wire.new(name: "C")

      LogicBus.new
        .push(LogicBusEvent.new(time: 0, value: false, wire: a))
        .push(LogicBusEvent.new(time: 0, value: false, wire: b))
        .push(LogicBusEvent.new(time: 0, value: false, wire: c))
        .push(LogicBusEvent.new(time: 300, value: true, wire: a))
        .push(LogicBusEvent.new(time: 600, value: true, wire: b))
        .push(LogicBusEvent.new(time: 700, value: true, wire: c))
    end

    it "return ASCII for the event_bus" do
      expected_text =
        "A: ___‾‾‾‾‾‾‾‾‾\n\n" \
        "B: ______‾‾‾‾‾‾\n\n" \
        "C: _______‾‾‾‾‾\n\n" \

      expect(subject.log).to eq(expected_text)
    end
  end
end