require "./lib/wire"

RSpec.describe Wire do
  subject { described_class.new(true) }

  describe ".observe" do
    it "adds a new observer" do
      o = Object.new
      subject.observe(o)

      expect(subject.observers).to include(o)
    end
  end

  describe ".update" do
    it "sets the new value" do
      expect(subject.update(false).value).to eq(false)
    end
  end

  describe ".value" do
    it "returns the value" do
      expect(subject.value).to eq(true)
    end
  end
end