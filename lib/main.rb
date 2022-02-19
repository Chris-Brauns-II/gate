require "./lib/and_gate"
require "./lib/circuit"
require "./lib/logic_bus"
require "./lib/logic_bus_event"
require "./lib/logic_signal"
require "./lib/logic_time"
require "./lib/signal_log"
require "./lib/value_log"
require "./lib/wire"

require "pry"
require 'ruby2d'
require "time"

# Define a square shape.
@square = Square.new(x: 50, y: 50, size: 50, color: 'red', z: 1)

Line.new(
  x1: 125, y1: 100,
  x2: 125, y2: 400,
  width: 1,
  color: 'red',
  z: 0
)

Line.new(
  x1: 150, y1: 100,
  x2: 150, y2: 400,
  width: 1,
  color: 'white',
  z: 0
)

Line.new(
  x1: 175, y1: 100,
  x2: 175, y2: 400,
  width: 1,
  color: 'lime',
  z: 0
)

Line.new(
  x1: 200, y1: 100,
  x2: 200, y2: 400,
  width: 1,
  color: 'aqua',
  z: 0
)

@start_x = 0
@start_y = 0

@current_x = 50
@current_y = 50

@square_start_x = @current_x
@square_start_y = @current_y

@in_square = false

@down = false

# on :key_down do |event|
#   if event.key == 'j'
#   elsif event.key == 'l'
#   elsif event.key == 'i'
#   elsif event.key == 'k'
#   end
# end

on :mouse do |event|
  case event.type
  when :move
    if @down && @in_square
      @current_x = @square_start_x + (event.x - @start_x)
      @current_y = @square_start_y + (event.y - @start_y)
    end
  when :up
    @down = false
    @in_square = false
  when :down
    @down = true
    @in_square = true if @square.contains?(event.x, event.y)
    @start_x = event.x
    @start_y = event.y

    @square_start_x = @square.x
    @square_start_y = @square.y
  end
end

time = LogicTime.new

event_bus = LogicBus.new

a = Wire.new(name: "A")
b = Wire.new(name: "B")

c = Wire.new(name: "C")

and_gate = AndGate.new(
  a: a,
  b: b,
  event_bus: event_bus,
  output_wire: c,
  time: time 
)

d = Wire.new(name: "D")
e = Wire.new(name: "E")

second_and_gate = AndGate.new(
  a: c,
  b: d,
  event_bus: event_bus,
  output_wire: e,
  time: time
)

event_bus
  .push(LogicBusEvent.new(time: 0, value: false, wire: a))
  .push(LogicBusEvent.new(time: 0, value: false, wire: b))
  .push(LogicBusEvent.new(time: 0, value: false, wire: c))
  .push(LogicBusEvent.new(time: 0, value: true, wire: d))
  .push(LogicBusEvent.new(time: 0, value: false, wire: e))
  .push(LogicBusEvent.new(time: 300, value: true, wire: a))
  .push(LogicBusEvent.new(time: 600, value: true, wire: b))
  .push(LogicBusEvent.new(time: 800, value: false, wire: d))
  .push(LogicBusEvent.new(time: 900, value: false, wire: b))


circuit = Circuit.new(event_bus: event_bus, logic_time: time)

time_log = ValueLog.new([a,b,c,d,e], time: time) do |l|
  # system "clear"
  # puts l
end

log = SignalLog.new(event_bus, time: time) do |l|
  # puts l
end

puts "SHOW"

update do
  puts Time.now
  time.step_temporal
  @square.x = @current_x
  @square.y = @current_y

  @square.color = (c.value == true ? "red" : "lime")
end

show
