require "./spec/spec_helper"

require "./lib/circuit"

RSpec.describe Circuit do
  let(:event_bus) do
    LogicBus
      .new
      .push(LogicBusEvent.new(time: 100, value: true, wire: a))
      .push(LogicBusEvent.new(time: 100, value: true, wire: b))
  end
  let(:a) { Wire.new(false) }
  let(:b) { Wire.new(false) }

  let(:wire_observer) do
    AndGate.new(
      a: a,
      b: b,
      event_bus: event_bus,
      output_wire: Wire.new(false),
      time: logic_time,
    )
  end
  let(:logic_time) { LogicTime.new }

  describe ".update_time" do
    subject { described_class.new(event_bus: event_bus, logic_time: logic_time).update_time(time) }

    context "when there are events for the current time" do
      let(:time) { 100 }

      it "updates Wire values" do
        expect { subject }
          .to change { a.value }.from(false).to(true)
      end

      it "tells Wire Observers to evaluate" do
        expect(wire_observer).to receive(:evaluate)

        subject
      end
    end
  end
end