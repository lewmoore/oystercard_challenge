class Journey_log

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @history = []
  end

  def start(entry_station)
    @journey = @journey_class.new(entry_station)
  end

  def finish(exit_station, journey = @journey)
    journey.complete_journey(exit_station)
    @history << journey
  end

  def journeys
    @history.dup
  end

  private

  def current_journey
    return start(entry_station) if @journey.nil?
    @journey
  end
end
