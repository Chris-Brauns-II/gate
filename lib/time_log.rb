class TimeLog
  attr_reader :wires

  def initialize(wires, time:)
    @wires = wires

    time.observe(self)
  end

  def update_time(time)
    return unless time % 100 == 0

    output = "Time:\t#{time}\n"
    wires.each do |wire|
      output += "#{wire.name}:\t#{wire.value}\n"
    end
    output += "\n"
    # puts output

    output
  end
end