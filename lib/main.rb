require "./lib/and_gate"
require "./lib/circuit"
require "./lib/logic_bus"
require "./lib/logic_bus_event"
require "./lib/logic_signal"
require "./lib/logic_time"
require "./lib/signal_log"
require "./lib/time_log"
require "./lib/wire"

require "cli/ui"
require "tty-box"


# box = TTY::Box.frame(width: 30, height: 10, title: {top_left: "TITLE", bottom_right: "v1.0"})
box = TTY::Box.warn("Deploying application")

print box