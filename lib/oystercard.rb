# Oystercard

require_relative 'station.rb'

class Oystercard
  attr_reader :balance, :entry_station, :journey_history, :exit_station

  MAX_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "There is a limit of #{MAX_AMOUNT}" if amount > MAX_AMOUNT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "you have already touched in" if in_journey?
    raise "you dont have enough money" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    raise "you are not touched in" unless in_journey?
    deduct(MINIMUM_FARE)
    @exit_station = station
    add_journey_to_history
    @entry_station = nil
  end

  def add_journey_to_history
    @journey_history << {entry_station: @entry_station, exit_station: @exit_station}
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
