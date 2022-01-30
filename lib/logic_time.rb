class LogicTime
  def current
    @current ||= 0
  end

  def observe(observer)
    observers.push(observer)
  end

  def observers
    @observers ||= []
  end

  def run(start: 0, finish: 1000)
    (start..finish).each do |i|
      # sleep 0.01
      @current = i
      observers.each { |o| o.update_time(current) }
    end
  end
end