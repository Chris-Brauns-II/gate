require "spec_helper"

require "./lib/logic_time"
require "./lib/value_log"

RSpec.describe ValueLog do
  subject { described_class.new(wires, time: time, &the_proc) }

  let(:time) { LogicTime.new }
  let(:wires) do
    [
      a,
      b
    ]
  end
  let(:a) { Wire.new(false, name: "A") }
  let(:b) { Wire.new(true, name: "B") }
  let(:the_proc) { Proc.new { |_| } }

  describe ".initialize" do
    it "observes time" do
      expect(time).to receive(:observe).with(an_instance_of(described_class))

      subject
    end
  end

  describe ".update_time" do
    let(:expected_log) do
      "Time:\t0\n" \
      "A:\tfalse\n" \
      "B:\ttrue\n\n"
    end

    it "only logs for increments of 100" do
      expect(subject.update_time(1)).to eq(nil)
    end

    it "logs the event bus at the current time" do
      expect(subject.update_time(0)).to eq(expected_log)
    end

    it "calls the_proc" do
      expect(the_proc).to receive(:call).with(expected_log)

      subject.update_time(0)
    end
  end
end