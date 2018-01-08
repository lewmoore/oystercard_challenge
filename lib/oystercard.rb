class Oystercard

  attr_reader :balance
  MAX_AMOUNT = 90
  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "the oystercard cannot store above #{MAX_AMOUNT}" if amount > MAX_AMOUNT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    true
  end
end
