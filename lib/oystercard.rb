# Oystercard!
class Oystercard

  MAX_BALANCE = 90.0
  MINIMUM_FARE = 1.0
  INITIAL_BALANCE = 0.0

  attr_reader :balance, :in_journey

  def initialize(balance = INITIAL_BALANCE)
    error_message = "You cannot create a card with more than £#{MAX_BALANCE}"
    raise error_message if balance > MAX_BALANCE
    @balance = balance
    @in_journey = false
  end

  def top_up(money)
    error_message = "You cannot load more than £#{MAX_BALANCE}"
    raise error_message if balance + money > MAX_BALANCE
    @balance += money
  end

  def touch_in
    error_message = "You are broken, not even a £#{MINIMUM_FARE} left"
    raise error_message if balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

private

  def deduct(money)
    @balance -= money
  end

end
