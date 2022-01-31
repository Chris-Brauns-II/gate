require "spec_helper"

require "./lib/signal_log"
require "./lib/logic_bus"
require "./lib/logic_bus_event"
require "./lib/wire"

RSpec.describe SignalLog do
  subject { described_class.new(event_bus, time: time, length: 1, &the_proc) }

  let(:time) do
    o = double(:current => time_value)
    o.stub(:observe).with(an_instance_of(described_class))
    o
  end
  let(:time_value) { 0 }
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
  let(:the_proc) do
    Proc.new { |_| }
  end

  describe ".initialize" do
    it "observes time" do
      expect(time).to receive(:observe).with(an_instance_of(described_class))

      subject
    end
  end

  describe ".log" do

    context "at the end" do
      let(:time_value) { 700 }

      it "return ASCII for the event_bus" do
        expected_text =
          "A: ___‾‾‾‾‾\n\n" \
          "B: ______‾‾\n\n" \
          "C: _______‾\n\n" \

        expect(subject.log).to eq(expected_text)
      end
    end

    context "at the beginning" do
      let(:time_value) { 100 }

      it "return ASCII for the event_bus at the current point in time" do
        expected_text =
          "A: __\n\n" \
          "B: __\n\n" \
          "C: __\n\n" \

        expect(subject.log).to eq(expected_text)
      end
    end
  end

  describe ".update_time" do
    let(:expected_text) do
      "A: _\n\n" \
      "B: _\n\n" \
      "C: _\n\n" \
    end

    it "logs" do
      expect(subject.update_time(0)).to eq(expected_text)
    end

    it "calls the the_proc" do
      expect(the_proc).to receive(:call).with(expected_text)

      subject.update_time(0)
    end
  end
end