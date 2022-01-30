require "spec_helper"

require "./lib/logic_time"
require "./lib/time_log"

RSpec.describe TimeLog do
  subject { described_class.new(wires, time: time) }

  let(:time) { LogicTime.new }
  let(:wires) do
    [
      a,
      b
    ]
  end
  let(:a) { Wire.new(false, name: "A") }
  let(:b) { Wire.new(true, name: "B") }

  describe ".initialize" do
    it "observes time" do
      expect(time).to receive(:observe).with(an_instance_of(described_class))

      subject
    end
  end

  describe ".update_time" do
    it "only logs for increments of 100" do
      expect(subject.update_time(1)).to eq(nil)
    end

    it "logs the event bus at the current time" do
      expected_log = 
        "Time:\t0\n" \
        "A:\tfalse\n" \
        "B:\ttrue\n\n"

      expect(subject.update_time(0)).to eq(expected_log)
    end
  end
end