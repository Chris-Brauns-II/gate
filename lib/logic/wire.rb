class Wire
  attr_reader :name, :observers, :value

  def initialize(value = false, name: "X")
    @value = value
    @name = name
    @observers = []
  end

  def update(value)
    @value = value

    self # Is this a bad idea?
  end

  def observe(observer)
    observers.push(observer)
  end
end