require "spec_helper"

require "./lib/logic/logic_time"

RSpec.describe LogicTime do
  subject { described_class.new }

  let(:o) do
    o = double
    allow(o).to receive(:update_time).with(an_instance_of(Integer))
    subject.observe(o)
    o
  end

  describe ".current" do
    it "returns the current time" do
      expect(subject.current).to eq(0)
    end
  end

  describe ".observe" do
    it "adds the object to the observers" do
      expect(subject.observers).to include(o)
    end
  end

  describe ".run_async" do
    it "runs for 10 and calls the observer every time" do
      (0..10).each do |i|
        expect(o).to receive(:update_time).with(i)
      end

      subject.run_async(finish: 10)
      
      expect(subject.current).to eq(10)
    end
  end

  describe ".run_temporal" do
    let(:start_time) { Time.new(2020, 1, 1, 0, 0, 0) }

    before do
      allow(Time).to receive(:now).and_return(
        Time.parse("2022-01-01 00:00:00.00000 -0500"),
        Time.parse("2022-01-01 00:00:00.00000 -0500"),
        Time.parse("2022-01-01 00:00:10.00100 -0500"),
        Time.parse("2022-01-01 00:00:11.00000 -0500"),
      )
    end

    it "runs for 1000 and calls the observer with the conversion of the wall clock time" do
      expect(o).to receive(:update_time).with(0)
      expect(o).to receive(:update_time).with(1000)


      subject.run_temporal(finish: 1000)
    end
  end

  describe ".step_temporal" do
    let(:start_time) { Time.new(2020, 1, 1, 0, 0, 0) }

    before do
      allow(Time).to receive(:now).and_return(
        Time.parse("2022-01-01 00:00:00.00000 -0500"),
        Time.parse("2022-01-01 00:00:00.00000 -0500"),
        Time.parse("2022-01-01 00:00:10.00100 -0500"),
        Time.parse("2022-01-01 00:00:11.00000 -0500")
      )
    end

    it "steps once" do
      expect(o).to receive(:update_time).with(0)
      expect(o).not_to receive(:update_time).with(10)

      subject.step_temporal
    end

    it "steps twice" do
      expect(o).to receive(:update_time).with(0)
      expect(o).to receive(:update_time).with(1000)

      subject.step_temporal
      subject.step_temporal
    end
  end

  describe ".refresh" do
    it "calls its observers with the current time" do
      expect(o).to receive(:update_time).with(0)

      subject.refresh
    end
  end
end