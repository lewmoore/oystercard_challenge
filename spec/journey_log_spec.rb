require 'journey_log.rb'

describe Journey_log do
  let(:journey) { double :journey, complete_journey: nil }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey_class) { double :journey_class, new: journey }
  subject(:journey_log) { described_class.new(journey_class) }

  it 'should start a journey' do
    allow(journey_class).to receive(:new).and_return journey
    expect(journey_log.start(entry_station)).to eq journey
  end

  it 'should end a journey' do
    expect(journey).to receive(:complete_journey)
    journey_log.finish(exit_station, journey)
  end

  it 'adds a journey to history array' do
    journey_log.finish(exit_station, journey)
    expect(journey_log.journeys).to include journey
  end

  it 'returns a list of journeys' do
    expect(journey_log.journeys).to eq []
  end
end
