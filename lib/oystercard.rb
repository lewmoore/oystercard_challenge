# Oystercard

require_relative 'station.rb'
require_relative 'journey.rb'


class Oystercard
  attr_reader :balance, :entry_station, :journey_history

  MAX_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize (journey_class = Journey)
    @balance = 0
    @journey_class = journey_class
    @journey_history = []
  end

  def top_up(amount)
    raise "There is a limit of #{MAX_AMOUNT}" if limit_exceeded?(amount)
    @balance += amount
  end

  def in_journey?
    !!@journey
  end

  def touch_in(station)
    raise "you dont have enough money" if low_balance?
    @journey = @journey_class.new(station)
  end

  def touch_out(station, journey = @journey)
    deduct(MINIMUM_FARE)
    journey.complete_journey(station)
    add_journey_history
  end


  private

  def add_journey_history
    @journey_history << @journey
  end

  def deduct(amount)
    @balance -= amount
  end

  def limit_exceeded?(amount)
    amount > MAX_AMOUNT
  end

  def low_balance?
    @balance < MINIMUM_FARE
  end
end
