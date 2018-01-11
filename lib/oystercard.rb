# Oystercard

require_relative 'station.rb'
require_relative 'journey.rb'
require_relative 'journey_log'


class Oystercard
  attr_reader :balance, :entry_station, :journey_history

  MAX_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize (journey_class = Journey, journey_log_class = Journey_log)
    @balance = 0
    @journey_class = journey_class
    @journey_log = journey_log_class.new
  end

  def top_up(amount)
    raise "There is a limit of #{MAX_AMOUNT}" if limit_exceeded?(amount)
    @balance += amount
  end

  def in_journey?
    !!@journey
  end

  def touch_in(station, journey_log = @journey_log)
    raise "you dont have enough money" if low_balance?
    journey_log.start(station)
  end

  def touch_out(station, journey = @journey)
    deduct(MINIMUM_FARE)
    @journey_log.finish(station)
  end


  private

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
