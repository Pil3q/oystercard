# Oystercard!
class Oystercard
  MAX_BALANCE = 90.0
  MINIMUM_FARE = 1.0
  INITIAL_BALANCE = 0.0
  attr_reader :balance, :journeylog
  def initialize(balance = INITIAL_BALANCE, journeylog = JourneyLog.new)
    @balance = balance
    @journeylog = journeylog
  end

  def top_up(money)
    @balance += money
    error_message = "You cannot load more than £#{MAX_BALANCE}"
    raise error_message if balance + money > MAX_BALANCE
  end

  def touch_in(station)
    error_message = "You are broken, not even a £#{MINIMUM_FARE} left"
    raise error_message if balance < MINIMUM_FARE
    deduct(journeylog.fare) if journeylog.current_journey.key?(:start)
    journeylog.start(station)
  end

  def touch_out(station)
    journeylog.end(station)
    deduct(journeylog.fare)
    journeylog.journey.single = {}
  end

  def journeys
    journeylog.log.each { |journey|
      if !journey[:start].nil?
        p "Entry station: #{journey[:start].name}, zone: #{journey[:start].zone}"
      else
        p 'No entry station'
      end
      if !journey[:end].nil?
        p "Exit station: #{journey[:end].name}, zone: #{journey[:end].zone}"
      else
        p 'No exit station'
      end }
  end

  private

  def deduct(money)
    @balance -= money
  end
end
