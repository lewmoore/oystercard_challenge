require 'oystercard'


MAX_AMOUNT = 90

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  describe 'Balance' do
    it "has a balance of 0" do
      expect(oystercard.balance).to eq 0
    end
  end

  describe 'journey history' do
    it "has an empty journey history at start" do
      expect(oystercard.journey_history).to be_empty
    end

    it "stores entry station and exit station" do
      oystercard.top_up(30)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journey_history).to eq [journey]
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
      before do
        oystercard.top_up(30)
        oystercard.touch_in(entry_station)
      end

      it { is_expected.to respond_to(:touch_in).with(1).argument }

        it 'touching in changes status to true' do
          expect(oystercard.in_journey?).to eq true
        end

        it 'touching in twice will raise an error' do
          expect {oystercard.touch_in(entry_station)}.to raise_error "you have already touched in"
          end

        it 'Can identify previous entry station' do
          expect(oystercard.entry_station).to eq entry_station
        end
      end

      context 'insufficient balance' do
        it 'if balance is below the minimum fare, card wont touch in' do
          expect {oystercard.touch_in(entry_station)}.to raise_error "you dont have enough money"
        end
      end
    end

    describe '#touch_out' do
      context 'sufficient balance' do
        before do
          oystercard.top_up(30)
          oystercard.touch_in(entry_station)
          oystercard.touch_out(exit_station)
        end

          it 'card can be used to touch out' do
              expect(oystercard).not_to be_in_journey
            end
          it 'sets entry station to nil when touching out' do
            expect(oystercard.entry_station).to eq nil
          end

          it 'stores exit station' do
            expect(oystercard.exit_station).to eq exit_station
          end

      end

      it 'is expected to deduct fare when touching out' do
        oystercard.top_up(30)
        oystercard.touch_in(entry_station)
        expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by (-Oystercard::MINIMUM_FARE)
      end

      it 'touch out fails without touching in' do
        expect {oystercard.touch_out(exit_station)}.to raise_error "you are not touched in"
      end

      it 'Card is not in a journey by default' do
        expect(oystercard.in_journey?).to eq false
      end
    end
end
