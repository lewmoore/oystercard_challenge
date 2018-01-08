require 'oystercard'

MAX_AMOUNT = 90

describe Oystercard do
  subject(:oystercard) { described_class.new }
  it { is_expected.to respond_to :balance }

  describe 'Balance' do
    it "has a balance of 0" do
      expect(oystercard.balance).to eq 0
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

  describe '#top_up' do
    it "to deduct money from oystercard" do
      oystercard.top_up(30)
      expect(oystercard.deduct(10)).to eq 20
    end
  end

  describe '#touch_in' do
    it 'touching in changes status to true' do
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end

    it 'touching in twice will raise an error' do
        oystercard.touch_in
        expect {oystercard.touch_in}.to raise_error "you have already touched in"
      end
    end
    describe '#touch_out' do
      it 'card can be used to touch out' do
          oystercard.touch_in
          oystercard.touch_out
          expect(oystercard).not_to be_in_journey
        end

      it 'touch out fails without touching in' do
        expect {oystercard.touch_out}.to raise_error "you are not touched in"
        end

    it 'Card is not in a journey by default' do
      expect(oystercard.in_journey?).to eq false
    end
  end
end
