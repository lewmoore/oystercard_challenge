require 'oystercard'


MAX_AMOUNT = 90

describe Oystercard do

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey_class) { double :journey_class, new: nil }
  let(:journey) { double :journey }
  let(:journey_log) { double :journey_log, start: nil, finish: nil }
  let(:journey_log_class) { double :journey_log_class, new: nil }
  subject(:oystercard) { described_class.new(journey_class) }

  describe '#initialize' do
    it "has a balance of 0" do
      expect(oystercard.balance).to eq 0
    end

    it 'creates a journey log' do
      expect(journey_log_class).to receive(:new)
      Oystercard.new(journey_class, journey_log_class)
    end

  end

  describe '#top_up' do
    it "tops up the oystercard" do
      expect(oystercard.top_up(10)).to eq 10
    end

    it "to raise an error if top up amount is greater than 90" do
      expect {oystercard.top_up(100)}.to raise_error "There is a limit of #{MAX_AMOUNT}"
    end
  end

  describe '#touch_in' do
    context 'sufficient balance' do
        it 'creates a new journey' do
          oystercard.top_up(10)
          allow(journey_log).to receive(:start).and_return journey
          expect(oystercard.touch_in(entry_station, journey_log)).to eq journey
        end
      end

      context 'insufficient balance' do
        it 'if balance is below the minimum fare, card wont touch in' do
          expect {oystercard.touch_in(entry_station)}.to raise_error "you dont have enough money"
        end
      end
    end

    describe '#touch_out' do

    it 'sets entry station to nil when touching out' do
        expect(oystercard.entry_station).to eq nil
      end

      it 'is expected to deduct fare when touching out' do
        oystercard.top_up(30)
        allow(journey).to receive(:complete_journey)
        oystercard.touch_in(entry_station)
        expect { oystercard.touch_out(exit_station, journey) }.to change { oystercard.balance }.by (-Oystercard::MINIMUM_FARE)
      end
    end
end
