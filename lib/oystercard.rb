class Oystercard

  attr_reader :balance, :status

  MAX_AMOUNT = 90

  def initialize
    @balance = 0
    @status = false
  end

  def top_up(amount)
    raise "the oystercard cannot store above #{MAX_AMOUNT}" if amount > MAX_AMOUNT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @status
  end

  def touch_in
    @status = true
  end

  def touch_out
    @status = false
  end
end
