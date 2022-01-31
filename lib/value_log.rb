class ValueLog
  attr_reader :wires

  def initialize(wires, time:, &block)
    @wires = wires
    @time_callback = block

    time.observe(self)
  end

  def update_time(time)
    return unless time % 100 == 0

    output = "Time:\t#{time}\n"
    wires.each do |wire|
      output += "#{wire.name}:\t#{wire.value}\n"
    end
    output += "\n"

    output.tap { |o| time_callback.call(o) }
  end

  private

  attr_reader :time_callback
end