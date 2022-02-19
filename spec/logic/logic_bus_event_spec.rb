require "./lib/logic/logic_bus_event"

RSpec.describe LogicBusEvent do
  describe ".==" do
    it "equals if the values are equal" do
      wire = Wire.new(false)

      expect(described_class.new(wire: wire, value: false, time: 0)).to eq(described_class.new(wire: wire, value: false, time: 0))
    end
  end
end