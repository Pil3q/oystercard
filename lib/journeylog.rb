class JourneyLog
  attr_reader :log, :journey
  def initialize(journey = Journey.new)
    @log = []
    @journey = journey
  end

  def start(station)
    @log << journey.single if current_journey.key?(:start)
    journey.start(station)
  end

  def end(station)
    @log << journey.single
    journey.end(station)
  end

  def current_journey
    journey.single
  end

  def fare
    journey.fare
  end
end
