# Oystercard

require_relative 'station.rb'

class Oystercard
  attr_reader :balance, :entry_station

  MAX_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "There is a limit of #{MAX_AMOUNT}" if amount > MAX_AMOUNT
    @balance += amount
  end

  def in_journey?
    return true unless @entry_station == nil
    return false
    
  end

  def touch_in(station)
    raise "you have already touched in" if in_journey?
    raise "you dont have enough money" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    raise "you are not touched in" unless in_journey?
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
