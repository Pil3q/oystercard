# Oystercard!
class Oystercard

  MAX_BALANCE = 90.0
  MINIMUM_FARE = 1.0
  INITIAL_BALANCE = 0.0

  attr_reader :balance, :journey_history, :journey

  def initialize(balance = INITIAL_BALANCE, journey = Journey.new)
    error_message = "You cannot create a card with more than £#{MAX_BALANCE}"
    raise error_message if balance > MAX_BALANCE
    @balance = balance
    @journey = journey
    @journey_history = []
  end

  def top_up(money)
    error_message = "You cannot load more than £#{MAX_BALANCE}"
    raise error_message if balance + money > MAX_BALANCE
    @balance += money
  end

  def touch_in(station)
    error_message = "You are broken, not even a £#{MINIMUM_FARE} left"
    raise error_message if balance < MINIMUM_FARE
    if journey.single.key?(:start)
      @journey_history << journey.single
      deduct(journey.fare)
    end
    journey.start(station)
  end

  def touch_out(station)
    @journey_history << journey.single
    journey.end(station)
    deduct(journey.fare)
    journey.single = {}
  end

private

  def deduct(money)
    @balance -= money
  end

end
