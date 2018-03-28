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
    if !complete?
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

private

  def complete?
     @single.key?(:start) && @single.key?(:end)
  end
end
