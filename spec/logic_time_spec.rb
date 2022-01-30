require "./lib/logic_time"

RSpec.describe LogicTime do
  subject { described_class.new }

  describe ".current" do
    it "returns the current time" do
      expect(subject.current).to eq(0)
    end
  end

  describe ".observe" do
    it "adds the object to the observers" do
      o = Object.new
      subject.observe(o)

      expect(subject.observers).to include(o)
    end
  end

  describe ".run" do
    it "runs for 100 and calls the observer every time" do
      o = double.stub(:update_time).with(an_instance_of(Integer))
      subject.observe(o)

      (0..10).each do |i|
        expect(o).to receive(:update_time).with(i)
      end

      subject.run(finish: 10)
      
      expect(subject.current).to eq(10)
    end
  end
end