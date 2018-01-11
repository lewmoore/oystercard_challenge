require 'journey'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  subject(:journey) { described_class.new(entry_station) }

  describe '#initialize' do
    it 'assigns entry_station instance variable' do
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe '#complete_journey' do
    it 'assigns exit station instance variable' do
      journey.complete_journey(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe '#fare' do
    it 'fare issues a penalty for incomplete journey' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns minimum fare for ocmpleted journey' do
      journey.complete_journey(exit_station)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end
  end
end
