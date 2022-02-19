require "./lib/and_gate"
require "./lib/logic_bus"
require "./lib/logic_bus_event"
require "./lib/logic_time"
require "./lib/wire"

RSpec.describe AndGate do
  describe ".initialize" do
    subject do
      described_class.new(
        a: a,
        b: b,
        logic_bus: LogicBus.new,
        output_wire: Wire.new(false),
        time: LogicTime.new
      )
    end
    let(:a) { Wire.new(false) }
    let(:b) { Wire.new(false) }

    it "observes to A and B" do
      expect(a.observers).to include(subject)
      expect(b.observers).to include(subject)
    end
  end

  describe ".evaluate" do
    subject do
      described_class.new(
        a: a,
        b: b,
        logic_bus: logic_bus,
        output_wire: c,
        time: time
      )
    end
    let(:c) { Wire.new(false) }
    let(:logic_bus) { LogicBus.new }
    let(:time) { LogicTime.new }

    context "when A and B are true" do
      let(:a) { Wire.new(true) }
      let(:b) { Wire.new(true) }

      context "and C is false" do
        let(:c) { Wire.new(false) }
        it "publishes a true event for C at 100 greater than the current time" do
          subject.evaluate

          expect(logic_bus.bus).to include(LogicBusEvent.new(wire: c, value: true, time: time.current + 100))
        end
      end

      context "and C is true" do
        let(:c) { Wire.new(true) }

        it "does not publish" do
          expect(logic_bus.bus).to be_empty
        end
      end
    end
  end
end