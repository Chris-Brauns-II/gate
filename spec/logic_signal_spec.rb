require "./lib/logic_signal"

RSpec.describe LogicSignal do
  subject { described_class.new(value) }

  describe ".value" do
    context "1 value" do
      let(:value) { 1 }

      it "returns a value" do
        expect(subject.value).to eq(1)
      end
    end

    context "0 value" do
      let(:value) { 0 }

      it "returns a value" do
        expect(subject.value).to eq(0)
      end
    end
  end
end