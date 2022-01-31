class LogicTime
  attr_reader :start_time

  def initialize
    @start_time = Time.now
  end

  def current
    @current ||= 0
  end

  def observe(observer)
    observers.push(observer)
  end

  def observers
    @observers ||= []
  end

  def refresh(curr = current)
    @current = curr
    observers.each { |o| o.update_time(current) }
  end

  def run_async(start: 0, finish: 1000)
    (start..finish).each do |i|
      refresh(i)
    end
  end

  def run_temporal(start: 0, finish: 1000)
    while reload_logic_time <= finish
      refresh(logic_time)
    end
  end

  private

  attr_reader :logic_time

  def reload_logic_time
    now = Time.now
    @logic_time = ((now - start_time) * 100).to_i
  end
end