# Oystercard!
class Oystercard
  MAX_BALANCE = 90.0
  attr_reader :balance, :in_journey
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    error_message = "You cannot load more than #{MAX_BALANCE}"
    raise error_message if balance + money.to_f > MAX_BALANCE
    @balance += money.to_f
  end

  def deduct(money)
    @balance -= money.to_f
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
