class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station
  attr_accessor :single
  def initialize
  @single = {}
  end

  def start(station)
    @entry_station = station
    @single = {} if @single.key?(:start)
    @single.store(:start, entry_station)
  end

  def end(station)
    @exit_station = station
    @single.store(:end, exit_station)
  end

  def fare
    return PENALTY_FARE if !complete?
    return MINIMUM_FARE
  end

private

  def complete?
     @single.key?(:start) && @single.key?(:end)
  end
end
