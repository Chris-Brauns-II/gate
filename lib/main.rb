require "./lib/and_gate"
require "./lib/circuit"
require "./lib/logic_bus"
require "./lib/logic_bus_event"
require "./lib/logic_signal"
require "./lib/logic_time"
require "./lib/signal_log"
require "./lib/time_log"
require "./lib/wire"

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
  .push(LogicBusEvent.new(time: 0, value: true, wire: d))
  .push(LogicBusEvent.new(time: 300, value: true, wire: a))
  .push(LogicBusEvent.new(time: 600, value: true, wire: b))
  .push(LogicBusEvent.new(time: 900, value: false, wire: b))


circuit = Circuit.new(event_bus: event_bus, logic_time: time)

time_log = TimeLog.new([a,b,c,d,e], time: time)

time.run(finish: 1000)

log = SignalLog.new(event_bus)

puts log.log