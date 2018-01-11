class Journey

  attr_reader :journey_history, :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def complete_journey(exit_station)
    @exit_station = exit_station
  end

  def fare
    return PENALTY_FARE if incomplete_journey?
    MINIMUM_FARE
  end

  private

    def incomplete_journey?
      @entry_station.nil? || @exit_station.nil?
    end
end
